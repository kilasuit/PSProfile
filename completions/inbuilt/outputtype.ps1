## As per this comment from MartinGC94

function TabExpansion2 {
    [CmdletBinding(DefaultParameterSetName = 'ScriptInputSet')]
    [OutputType([System.Management.Automation.CommandCompletion])]
    Param
    (
        [Parameter(ParameterSetName = 'ScriptInputSet', Mandatory = $true, Position = 0)]
        [string]
        $inputScript,

        [Parameter(ParameterSetName = 'ScriptInputSet', Position = 1)]
        [int]
        $cursorColumn = $inputScript.Length,

        [Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 0)]
        [System.Management.Automation.Language.Ast]
        $ast,

        [Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 1)]
        [System.Management.Automation.Language.Token[]]
        $tokens,

        [Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 2)]
        [System.Management.Automation.Language.IScriptPosition]
        $positionOfCursor,

        [Parameter(ParameterSetName = 'ScriptInputSet', Position = 2)]
        [Parameter(ParameterSetName = 'AstInputSet', Position = 3)]
        [Hashtable]
        $options = $null
    )
    End {
        $ExcludedTokenKinds = [System.Collections.Generic.HashSet[System.Management.Automation.Language.TokenKind]]@(
            [System.Management.Automation.Language.TokenKind]::LineContinuation
            [System.Management.Automation.Language.TokenKind]::NewLine
        )
        $ExcludedTypes = [System.Collections.Generic.HashSet[string]]@(
            'System.Byte'
            'System.String'
            'System.Object'
            'Microsoft.Management.Infrastructure.CimInstance'
            'System.Management.Automation.PSObject'
            'System.Management.Automation.PSCustomObject'
        )

        if ($psCmdlet.ParameterSetName -eq 'ScriptInputSet') {
            [System.Management.Automation.Language.Token[]]$tokens = $null
            $ParsedErrors = $null
            $ast = [System.Management.Automation.Language.Parser]::ParseInput($inputScript, [ref]$tokens, [ref]$ParsedErrors)
            $CursorOffset = $cursorColumn
        }
        if ($psCmdlet.ParameterSetName -eq 'AstInputSet') {
            $CursorOffset = $positionOfCursor.Offset
        }

        $TokenBeforeCursor = $tokens.Where({ $_.Extent.EndOffset -le $CursorOffset -and !$ExcludedTokenKinds.Contains($_.Kind) })[-1]

        if ($TokenBeforeCursor.Kind -eq [System.Management.Automation.Language.TokenKind]::Pipe) {
            $LastPipeline = $ast.Find({
                    param ($CurrentAst)
                    $CurrentAst.Extent.EndOffset -le $TokenBeforeCursor.Extent.StartOffset -and
                    $CurrentAst -is [System.Management.Automation.Language.PipelineAst]
                },
                $true
            )

            $LastPipelineElement = $LastPipeline.PipelineElements[-1]
            if ($LastPipelineElement -is [System.Management.Automation.Language.CommandAst]) {
                if (!$Script:ResultCache) {
                    $Script:ResultCache = @{}
                }
                $Result = $Script:ResultCache[$LastPipelineElement.GetCommandName()]
                if ($Result) {
                    return [System.Management.Automation.CommandCompletion]::new($Result, -1, $CursorOffset, 0)
                }
                $Command = Get-Command -Name $LastPipelineElement.GetCommandName() -ErrorAction Ignore
                if ($Command) {
                    $TypeToSearch = $Command.OutputType.Where({ !$ExcludedTypes.Contains($_.Name) }, [System.Management.Automation.WhereOperatorSelectionMode]::First, 1)[0]
                    $RelevantCommands = @(
                        if ($Command.Noun) {
                            Get-Command -Noun $Command.Noun
                        }
                        if ($TypeToSearch) {
                            Get-Command -CommandType Cmdlet, Function -ParameterType $TypeToSearch
                        }
                    ) | Select-Object -Unique
                    if ($RelevantCommands.Count -gt 0) {
                        [System.Collections.Generic.List[System.Management.Automation.CompletionResult]]$Result = foreach ($Item in $RelevantCommands) {
                            [System.Management.Automation.CompletionResult]::new(
                                $Item.Name, #CompletionText
                                $Item.Name, #ListItemText
                                [System.Management.Automation.CompletionResultType]::Command,
                                $Item.Name #ToolTip
                            )
                        }
                        $Script:ResultCache.Add($LastPipelineElement.GetCommandName(), $Result)
                        return [System.Management.Automation.CommandCompletion]::new($Result, -1, $CursorOffset, 0)
                    }
                }
            }
        }

        if ($psCmdlet.ParameterSetName -eq 'ScriptInputSet') {
            return [System.Management.Automation.CommandCompletion]::CompleteInput($inputScript, $cursorColumn, $options)
        }
        else {
            return [System.Management.Automation.CommandCompletion]::CompleteInput($ast, $tokens, $positionOfCursor, $options)
        }
    }
}
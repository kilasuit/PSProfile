<# To Come Back To
[System.Diagnostics.Process] | Add-Member -Name Elevated  -MemberType ScriptProperty -Value {if ($this.Name -in @('Idle','System')) {$null} else {-not $this.Path -and -not $this.Handle} }

$elevatedProcessTypeDataParams = @{
    TypeName   = 'System.Diagnostics.Process'
    MemberType = 'ScriptProperty'
    MemberName = 'Elevated'
    Value      = [ScriptBlock]::Create('{if ($this.Name -in @("Idle","System")) {$null} else {-not $this.Path -and -not $this.Handle} }')
    }

Update-TypeData @elevatedProcessTypeDataParams

#>

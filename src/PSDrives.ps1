if ($isWindows) {
    #New-PSDrive -Name Desktop -PSProvider FileSystem -Root $env:HOMEDRIVE$env:HOMEPATH\Desktop | Out-Null
    New-PSDrive -Name OneDrive -PSProvider FileSystem -Root $env:HOMEDRIVE$env:HOMEPATH\Onedrive\ | Out-Null
    New-PSDrive -Name OneDriveRK -PSProvider FileSystem -Root "$env:HOMEDRIVE$env:HOMEPATH\OneDrive - Kilasuit.org\" -ErrorAction SilentlyContinue | Out-Null
    New-PSDrive -Name Code -PSProvider FileSystem -Root C:\code\ | Out-Null
    New-PSDrive C-Tmp -PSProvider FileSystem -Root C:\Tmp\ | Out-Null
    New-PSDrive C-Temp -PSProvider FileSystem -Root c:\Temp\ | Out-Null
    $null = New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
    $null = New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS
}
if ($IsLinux) {
    New-PSDrive Code -PSProvider FileSystem -Root '/mnt/c/Code/' | Out-Null
    New-PSDrive C-Tmp -PSProvider FileSystem -Root '/mnt/c/Tmp/' | Out-Null
    New-PSDrive C-Temp -PSProvider FileSystem -Root '/mnt/c/Temp/' | Out-Null
    $Env:PSModulePath = $Env:PSModulePath + ':/mnt/c/Program Files/WindowsPowerShell/Modules/'
}

New-PSDrive -Name Private -PSProvider FileSystem -Root 'Code:\Mine\pri\' | Out-Null
New-PSDrive -Name Public -PSProvider FileSystem -Root 'Code:\Mine\pub\' | Out-Null

New-PSDrive -Name PriGH -PSProvider FileSystem -Root 'Code:\Mine\pri\Github\' | Out-Null
New-PSDrive -Name PubGH -PSProvider FileSystem -Root 'Code:\Mine\pub\Github\' | Out-Null

New-PSDrive -Name PubDocRepos -PSProvider FileSystem -Root 'PriGH:\kilasuit\Docs' | Out-Null

New-PSDrive -Name Scripts -PSProvider FileSystem -Root 'PriGH:\kilasuit\Scripts' | Out-Null
New-PSDrive -Name ScriptsWIP -PSProvider FileSystem -Root 'PriGH:\kilasuit\Scripts-WIP' | Out-Null
New-PSDrive -Name ModulesWIP -PSProvider FileSystem -Root 'PriGH:\kilasuit\Modules-WIP' | Out-Null

# GitHub Organizations
New-PSDrive -Name getpsuguk -PSProvider FileSystem -Root 'PubGH:\get-psuguk' | Out-Null
New-PSDrive -Name PSOrgUK -PSProvider FileSystem -Root 'PubGH:\PowerShellOrgUK' | Out-Null
New-PSDrive -Name DSC-Org -PSProvider FileSystem -Root 'PubGH:\DSCCommunity' | Out-Null
New-PSDrive -Name PS-GH -PSProvider FileSystem -Root 'PubGH:\PowerShell' | Out-Null
#New-PSDrive -Name PS-Modules -PSProvider FileSystem -Root 'PubGH:\PowerShellModules' | Out-Null


#New-PSDrive -Name PSOrgDev -PSProvider FileSystem -Root 'PubGH:\PowerShellOrgDev' | Out-Null

#New-PSDrive -Name Modules -PSProvider FileSystem -Root 'PriGH:\kilasuit\Modules' | Out-Null


# Sites
New-PSDrive -Name Blog -PSProvider FileSystem -Root 'PriGH:\kilasuit\blogsite' | Out-Null
New-PSDrive -Name kk -PSProvider FileSystem -Root 'PriGH:\kilasuit\sites\kilas-kitchen' | Out-Null # kk is short for kila's kitchen
New-PSDrive -Name Mhasl -PSProvider FileSystem -Root 'PriGH:\mhaslme\website' | Out-Null

# Not yet created
# New-PSDrive -Name PSugUK -PSProvider FileSystem -Root 'PubGH:\PowerShellOrgUK\site' | Out-Null
# New-PSDrive -Name INFamily -PSProvider FileSystem -Root 'PubGH:\InteractionNotes\site' | Out-Null
#New-PSDrive -Name PubMhasl -PSProvider FileSystem -Root 'PubGH:\mhaslme\website' | Out-Null

New-PSDrive -Name Profile -PSProvider FileSystem -Root 'PriGH:\kilasuit\PSProfile' | Out-Null


$PSDrives = $true

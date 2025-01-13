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

New-PSDrive -Name Scripts -PSProvider FileSystem -Root 'PriGH:\kilasuit\Scripts' | Out-Null
New-PSDrive -Name ScriptsWIP -PSProvider FileSystem -Root 'PriGH:\kilasuit\Scripts-WIP' | Out-Null
New-PSDrive -Name ModulesWIP -PSProvider FileSystem -Root 'PriGH:\kilasuit\Modules-WIP' | Out-Null
New-PSDrive -Name Blog -PSProvider FileSystem -Root 'PriGH:\kilasuit\blogsite' | Out-Null
New-PSDrive -Name Mhasl -PSProvider FileSystem -Root 'PriGH:\mhaslme\website' | Out-Null
New-PSDrive -Name Profile -PSProvider FileSystem -Root 'PriGH:\kilasuit\PSProfile' | Out-Null


$PSDrives = $true

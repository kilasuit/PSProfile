# This may not be needed in the future depending on future PSTeam work in this area
Import-Module CompletionPredictor
## This Module will throw a wobbler if there is no internet connectivity, so much so
## it will forcefully terminate the process that imports it
# as such I have added a check to see if the system is connected to the internet
# and if not, it will not import the module
# This is a bit of a hack but it works for now & I need to report this to Winget team as per Issue#19
if ((Get-NetConnectionProfile).IPv4Connectivity -NotMatch 'LocalNetwork') {
    Import-Module Microsoft.WinGet.CommandNotFound
}
# Think I have this elsewhere though may bring it in here again see Issue#20
#foreach ($file in Get-ChildItem -Path $($Profile.MyProfileDirectory)\src\completions\*\*.ps1 ) {
#     . $file.FullName
# }

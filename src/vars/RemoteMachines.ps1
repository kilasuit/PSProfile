## This is for setting up access to remote machines
if ($env:COMPUTERNAME -match '730') {
    $computerList = '192.168.0.17','192.168.0.26','192.168.0.15'
    $otherMachines = '192.168.0.33'
}
else {
    $computerList = @($env:COMPUTERNAME)
}

$WinRMComputerListUsingLoggedInUser =  New-PSSession -ComputerName $computerList
# $otherWinRMMachines = New-PSSession -ComputerName $otherMachines -Credential (Get-Credential)

# TODO: Add more things that should only load if inan admin session


# $admin = ((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
#     $WindowTitle = "$ver - $([System.Diagnostics.Process]::GetCurrentProcess() | Select-Object -ExpandProperty ID)"
#     $host.UI.RawUI.WindowTitle = $WindowTitle

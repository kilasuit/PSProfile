# Description: This script is used as part of an end of day commit routine

# Get-ChildItem -Path . -Filter *.md -Recurse | ForEach-Object {
#     $relativePath = $_.FullName | Resolve-Path -Relative
#     "[$($_.BaseName)]($relativePath)"
# } | Set-Clipboard

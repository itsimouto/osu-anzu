# Run this script through listLinks.bat.
# Dumps a listLinks.txt with all file/directory links.
# Issue: Also lists target files as HardLinks when they should be excluded. Needs to be fixed.

cd $PSScriptRoot\..\..

dir -recurse -force | ?{$_.LinkType} | select `
@{ Name="File Name"; Expression={$_.FullName | Resolve-Path -Relative} }, `
@{ Name="Type"; Expression={$_.LinkType} }, `
@{ Name="Target"; Expression={$_.Target[0] | Resolve-Path -Relative} } `
| Out-File $PSScriptRoot\listLinks.txt
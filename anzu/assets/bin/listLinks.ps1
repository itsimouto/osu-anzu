# Run powershell -ExecutionPolicy Bypass .
# Call this script from the skin's root (e.g., cd ...\osu!\Skins\yourSkinName).
# Lists all file/directory links.
dir -force | ?{$_.LinkType} | select `
@{ Name="File Name"; Expression={$_.FullName | Resolve-Path -Relative} }, `
@{ Name="Type"; Expression={$_.LinkType} }, `
@{ Name="Target"; Expression={$_.Target[0] | Resolve-Path -Relative} }

$packageDir = "mypackage"  # package dir name in src

$originalCwd = Get-Location
$scriptDir = $PSScriptRoot
Set-Location -Path $scriptDir

docker run -it -v "$(Resolve-Path .\src\$packageDir):/$packageDir" --rm package_runner python -m unittest discover $packageDir/
Set-Location -Path $originalCwd

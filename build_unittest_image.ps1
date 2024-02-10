$originalCwd = Get-Location
$scriptDir = $PSScriptRoot
Set-Location -Path $scriptDir

docker build -f "DockerfileUnittesting" . --label PackageRunner --rm --tag package_runner --add-host=deb.debian.org:185.46.212.88

Set-Location -Path $originalCwd

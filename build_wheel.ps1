$originalCwd = Get-Location
$scriptDir = $PSScriptRoot
Set-Location -Path $scriptDir

docker build -f "DockerfileBuildWheel" . --label WheelBuilder --rm --tag wheel_builder --add-host=deb.debian.org:185.46.212.88
docker create --name temp_container wheel_builder
docker cp temp_container:/dist/ ./dist/
docker rm temp_container

Set-Location -Path $originalCwd

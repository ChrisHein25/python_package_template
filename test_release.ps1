# This is a system integration test to BUILD and TEST a Python package

##### User Inputs #####
$packageDir = "mypackage"  # package top level directory
$projDir = "python_package_template"  # project (repo) name

#######################

$imageName = "package_runner"  # package runner image name used for testing
$pyTestFileName = "test_usage.py"  # python system testing file with usage tests
$containerName = "SystemTestMyPackage"  # what to name the container running the system testing


# Main Script Steps:
#  1. Build the .whl file (inputs in pyproject.toml)
#  2. Build the Docker image for Package runner
#  3. In the Docker environment, pip install the package .whl
#  4. Once installed, run a python import test file to test importing various submodules of the package
#  5. Once testing is complete, destroy the docker container


##### Path Setup #####

# Save the current working directory
$originalCwd = Get-Location
Write-Host "CWD: $originalCwd"

# Resolve the path to the script directory
$scriptDir = $PSScriptRoot
Write-Host "Target CWD: $scriptDir"

# Change the current working directory to the script directory
Set-Location -Path $scriptDir
Write-Host "CWD updated: $scriptDir"

##### MAIN SCRIPT #####

Write-Host "`nRUNNING RELEASE SCRIPT`n"

# run the unit tests
Write-Host "`nRUNNING UNIT TESTS...`n"

$runTestsPath = Join-Path $scriptDir "run_tests.ps1"
& $runTestsPath  # run unit tests

# Build Latest Wheel: Call build_wheel.ps1 from the package directory
Write-Host "`nCREATING DOCKER CONTAINER TO BUILD WHEEL AND BUILDING WHEEL...`n"

# first, delete any existing dist folder, if exists
Remove-Item -Path ".\dist" -Recurse -Force -ErrorAction SilentlyContinue


$buildWheelPath = Join-Path $scriptDir "build_wheel.ps1"
Write-Host "buildWheelPath: $buildWheelPath"
& $buildWheelPath  # build the latest wheel file, with all updated code

# Get the .whl file
$whlDir = "$scriptDir\..\$projDir\dist"
Write-Host "whlDir: $whlDir"

$latestWhl = Get-ChildItem $whlDir -Filter "$packageDir-*.whl" |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

# Check if a .whl file is found
if ($latestWhl) {

    Write-Host "Latest .whl file path: $($latestWhl.FullName)"

    # Step 1: Build the Docker image for the package runner
    Write-Host "`nBUILDING UNIT TEST DOCKER IMAGE...`n"

    # Build package Docker image
    $buildImagePath = Join-Path $scriptDir "build_unittest_image.ps1"
    Write-Host "buildImagePath: $buildImagePath"
    & $buildImagePath  # build the unit testing image to run system tests and build the wheel

    # Run a Docker container to do the system tests
    $containerId = docker run -d --name $containerName $imageName sleep infinity  # sleep infinity just keeps it on

    # Get the relative path of the .whl file from this script
    $relativeWhlPath = Join-Path "dist" $latestWhl.Name
    Write-Host "relativeWhlPath: $relativeWhlPath"

    # Copy .whl file to Docker container using relative path
    docker cp $relativeWhlPath "$($containerName):/tmp/"

    # Install the .whl file inside the Docker container
    docker exec $containerName pip install "/tmp/$($latestWhl.Name)"

    # copy the python file to run to Docker
    docker cp $pyTestFileName "$($containerName):/$pyTestFileName"

    Write-Host "`n-------------------`nRunning System Tests...`n"

    # Run Python test file inside the Docker container
    docker exec $containerName python $pyTestFileName

    Write-Host "`nSystem Tests Complete.`n-------------------`n"

    # Stop and remove the Docker container
    docker stop $containerName
    docker rm $containerName

} else {
    Write-Host "No .whl file found in $packageDir/dist directory. Build Failed!"
}


##### END MAIN SCRIPT #####


# Change back to the original working directory
Set-Location -Path $originalCwd
Write-Host "CWD returned: $originalCwd"
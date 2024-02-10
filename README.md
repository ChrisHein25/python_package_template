# Python Package Template (in Docker)

A generic template for Python package development.
The package is tested via Docker.
The template includes pre-build PowerShell scripts to run the release testing.

To use this template:
1. Build a new GitHub repo and select this as the template.
2. Rename the `src/mypackage` folder as your package name.
3. Update the `$packageDir` and `$projDir` variables at the top of the PowerShell scripts.
4. Run `test_release.ps1`. It should build a .whl file in `dist` folder.
5. The CI/CD pipeline is working. You can now replace the python code in your new package.
6. You will also want to update `test_usage.py` to reflect your new package name and system integration tests.



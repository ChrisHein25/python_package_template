# Python Package via Docker CI/CD

This GitHub repository template provides a streamlined approach to Python package development using Docker. Instead of relying on traditional methods such as virtual environments or Anaconda, this template leverages Docker to create an exact environment described by the `requirements.txt` file, ensuring consistency across different development environments.

### Prerequisites:

You only need Docker Desktop installed on your machine. Yes, you can literally develop a Python package *without installing Python*! 

Download Docker [here](https://www.docker.com/products/docker-desktop/). FYI, for commercial use Docker requires a small annual subscription fee.

### Features:
- **Containerized Environment**: Utilizes Docker to build and maintain a consistent, virtual development environment.
- **Automated Testing**: Runs unit tests within a Docker container to ensure package integrity.
- **Separate Build Container**: Includes a separate container for building `.whl` files, enhancing flexibility and modularity.

### Why Docker?

Docker offers several advantages over traditional development methods:

1. **Consistency**: Docker ensures that every developer works in the same environment regardless of their local setup, eliminating "it works on my machine" issues.
   
2. **Isolation**: With Docker containers, dependencies and libraries are isolated from the host system, preventing conflicts and ensuring reproducible builds.
   
3. **Portability**: Docker containers can be easily shared and deployed across different systems, making collaboration and deployment seamless.

### Usage:

Follow these steps to use the GitHub repository template:

1. Build a new GitHub repo and select this as the template.
2. Rename the `src/mypackage` folder as your package name.
3. Update the `$packageDir` and `$projDir` variables at the top of the PowerShell scripts.
4. Run `test_release.ps1`. It should build a .whl file in `dist` folder.
5. The CI/CD pipeline is working. You can now replace the python code in your new package.
6. You will also want to update `test_usage.py` to reflect your new package name and system integration tests.

OS-X friendly version coming out soon...


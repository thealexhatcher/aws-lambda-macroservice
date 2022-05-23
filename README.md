## Getting started

### Dev Container Info
Reference:
    https://code.visualstudio.com/docs/remote/containers
Dockerfile:
    The container image is based on Amazon Linux 2. This file is the definition for the development container. This installs baseline packages, installs python3 for the system, and configures the vscode user account. the vscode user account has packages installed via pip. The vscode user account terminal is also configured via .bashrc to open a new terminal with an active python virtual environment. It is intended that the python3 system install serve as the environment for VS Code and the configured virtual environment be used for development. 
devcontainer.json
    https://code.visualstudio.com/docs
    

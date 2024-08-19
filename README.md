# CHEME-4800-5800-Examples-Labs-Fall-2024
Repository for examples and labs for the CHEME 4/5800 course at Cornell for Fall 2024. 

## Requirements
This course uses [the Julia programming language](https://julialang.org/downloads/) to introduce fundamental concepts in programming, data science, machine learning, and artificial intelligence. 

### Installation
* Install Anaconda to your machine (if you don’t already have a working python/Jupyter installation): https://www.anaconda.com/download
* Install GitHub desktop to your machine: https://desktop.github.com/

Install the latest version of Julia on your machine: https://julialang.org/downloads/. For Windows users: Select the “add to path” option during installation to add Julia to your search path. For macOS users: update your .zshrc file in your home directory to include the path entry (edit using Nano or some other text editor): 
  * export PATH=“$PATH:/Applications/Julia-1.10.app/Contents/Resources/Julia/bin”
Alternatively, for macOS users, follow the instructions on the Julia website for updating the path:
  * https://julialang.org/downloads/platform/#optional_add_julia_to_path

Install Visual Studio Code (VSCode): https://code.visualstudio.com/download. Once VSCode is installed, add the Julia language extension via the extensions menu (open the extensions, search for Julia, and install the extension). 
* Open up a terminal window (zsh for macOS) in VSCode and type the command: julia
* Enter package mode by typing the ] key, and enter the command: add IJulia

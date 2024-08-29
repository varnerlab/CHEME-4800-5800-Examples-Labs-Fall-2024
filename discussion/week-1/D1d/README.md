# Lab 1d: Working with the Command Line Interfaces (CLIs) and the Julia, Python Interactive REPLs
The objective of `Lab 1d` is to get familiar with the Command Line Interfaces (CLIs), i.e., the terminal window in `VSCode` and the Julia, Python Interactive REPLs (Run-Evaluate-Print-Loop).
* __Motivation__: Why should we care about the command line in the age of Windows, Mac, and Linux GUIs (graphical user interfaces)? 

Many technical computing tasks are best done from the command line. For example, you may want to run a program 24/7 on a remote machine, run large jobs on a supercomputer, or use specialized hardware like a [Graphical Processing Unit (GPU)](https://en.wikipedia.org/wiki/Graphics_processing_unit). In these cases, you will need to use the command line. I use it daily, and I hope it's helpful.

I'm going to make a change.

## Lab 1d Topics
* You can download this lab by cloning the repository, downloading the zip file, or opening it directly in VSCode from the [course labs repository](https://github.com/varnerlab/CHEME-4800-5800-Examples-Labs-Fall-2024.git). Start `VSCode` from the `root` discussion directory.
* `VSCode` terminal window: you can start the `VSCode` terminal window by clicking on the `Terminal` menu item and then selecting `New Terminal` or using the keyboard shortcut `Ctrl+Shift+~.` This will open a terminal window at the bottom of the `VSCode` window. 
* You type commands into the terminal window and press `Enter` to execute them. You can also use the up and down arrow keys to scroll through previous commands. You can copy and paste text into (or from) the terminal window using the standard keyboard shortcuts `Ctrl+C` and `Ctrl+V` (or `Cmd+C` and `Cmd+V` on `macOS`). 

### Shell commands
The terminal window is a `shell` of some sort, e.g., `zsh` for me on macOS or perhaps `PowerShell` for Windows users. A `shell` is a command-line interpreter that listens for commands from the keyboard and executes them. The `shell` is the interface between you and the operating system. You can run different commands and programs from the `shell.` 

Let's look at a few `utility` type `shell` commands:
* command: `pwd` prints the current directory you are in. If your computer were a map, `pwd` would tell you where you are on the map.
* command: `cd` stands for change directory. For example, if you type `cd <something>` and press `Enter,` you will change to the `<something>` directory. 
    * `Catch`: The `<something>` directory must be visible, i.e., a subdirectory of the current directory. You can use the `ls` command to list the files and directories visible from the current directory.
    * If you type `cd ..` and press `Enter,` you will change to the parent directory of the current directory. If you type `cd ~` and press `Enter,` you will switch to your home directory. 
* command: `ls` lists the files in the current directory. There are many `flags` for the `ls` command. For example, `ls -a` lists all files, including hidden files. The command `ls -l` lists files in long format, including permissions, ownership, size, and modification date. The command `ls -t` lists files by modification time, while `ls -r` lists files in reverse order. You can combine flags, e.g., `ls -alt` lists all files in long format, including hidden files, sorted by modification time.

### `Python` and `Julia` REPLs   

#### Python
`Python` REPL: you can start the `Python` REPL (Run Evaluate Print Loop) by opening a new terminal window, typing `python,` and press `Enter.` You can exit the `Python` REPL by typing `exit()` and pressing `Enter`. To run a `Python` script, e.g., `HelloWorld.py,` from the `Python` REPL, you can type the command:
```python
exec(open("HelloWorld.py").read())
```
and press `Enter.` Let's look at the [exec function in the Python standard library](https://docs.python.org/3/library/functions.html#exec).
* `Python` is (mainly) an interpreted language. The first time you execute a `Python` script, it _may_ generate a `.pyc` file, which contains the compiled bytecode of the `Python` source file. The `Python` virtual machine then executes this bytecode. Subsequent executions may be faster because `Python` can use the compiled bytecode (no compile step), and loading the bytecode (presumably smaller) may be quicker. But the execution time is the same.
* We could also run the `HelloWorld.py` script from the terminal window by typing `python HelloWorld.py` and pressing `Enter.` Let's try it and see what happens. 

#### Julia
`Julia` is a high-level, high-performance dynamic programming language for technical computing. The `Julia` (Run Evaluate Print Loop) is a command line interface for `Julia.` You can type `Julia` commands into the `Julia` REPL and press `Enter` to execute them. You can also use the up and down arrow keys to scroll through previous commands. Start the `Julia` REPL by opening a new terminal window, typing `julia`, and pressing `Enter`. You can exit the `Julia` REPL by typing `exit()` and pressing `Enter`. 
* `Julia` is a compiled language — `Julia` compiles code on the fly (or it can also _precompile_ code if told to do so). The first time you execute a `Julia` script, it will take a little longer to run because `Julia` has to compile the code using the [Julia compiler and metaprogramming functionality](https://docs.julialang.org/en/v1/manual/metaprogramming/#Metaprogramming). Subsequent executions will be faster because `Julia` will use the compiled code.
* The `Julia` REPL can operate in one of several modes. For example, hitting the `?` key opens `Help mode,` pressing the `]` key opens `Package mode,` and pushing the `;` key opens `Shell mode.` You can exit these modes by pressing the `Backspace` key. You can find more information about the `Julia` REPL [here](https://docs.julialang.org/en/v1/stdlib/REPL/).
* To execute a `Julia` script, e.g., `HelloWorld.jl`, from the REPL, you can type the command:
```julia
include("HelloWorld.jl")
```
and press `Enter.` However, before we do this, let's look at the [include function in the Julia standard library](https://docs.julialang.org/en/v1/base/base/#Base.include).
* OK, now that we understand what `include` is doing, let's execute the `HelloWorld.jl` script. 
    * `Hmmm`: What assumption did we make about the location of the `HelloWorld.jl` file? Let's brainstorm some ways to fix this problem.

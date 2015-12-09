# Bootstrap
Clean C/C++ Makefile-based bootstrap environment for the QtCreator IDE.

### Usage
Make a copy of the Bootstrap folder and install.sh script in the desired project location, and run:

<code>
./install.sh MyProjectName
</code>

This creates a lightweight crossplatform makefile-based gcc/g++ project for use with QtCreator.

## Features

```bash
# Updates files and modules specified in your build system.
UpdateFiles.sh

# Generates a new class, UUID, header, and corresponding source file.
GenerateClass.sh ClassName
```

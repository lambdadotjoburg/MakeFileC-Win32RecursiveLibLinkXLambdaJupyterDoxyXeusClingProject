
### Automating Win32/C++ Programming `makefile`  

#### MakeFileC-Win32RecursiveLibLinkXLambdaJupyterDoxyXeusClingProject  
---
-  C++
-  Win32
-  MAKEFILE
-  DOXYGEN
-  Xeus-Cling
---
#### Core Library Features:

- Quick-launch Win32 GUI (`WinMain`, `WinMainW`) and console (main) applications.
- Automates project setup, documentation generation, and simplifies build processes.
- Industrial-quality, scalable project design.
- Provides a minimalistic, developer-centric interface.
---
This is a quick-project launch/setup/init `makefile` "library management system" that automates C/C++ project-related task-management processes. It enables programmers to write & build clean, efficient, and scalable "production-quality" applications using a single `makefile` setup for easy deployment, compilation & documentation.

This project aims to reduce the burden on programmers by automating repetitive tasks required to build and maintain scalable applications. The `makefile` recipes streamline project setup/deployment/compilation & documentation, allowing developers to focus on core logic.

The project helps maintain simple-yet-powerful "high-quality" C++ applications by providing developer-friendly interfaces for quick-setup and instructions. It simplifies project maintenance using macro principles and abstracts away intricate project-related complexities for easy maintenance.

---
#### Win32 Resources:

- [The Forget's Win32 Program Tutorials](http://www.winprog.org/tutorial/start.html)
- [Making Win32 API Being Unicode Friendly](https://cplusplus.com/forum/articles/16820/#google_vignette)
- [Transmission Zero - Building Win32 GUI Applications with MinGW](https://www.transmissionzero.co.uk/computing/win32-apps-with-mingw/)
- [Managing Application State - An Object Oriented Approach](https://learn.microsoft.com/en-us/windows/win32/learnwin32/managing-application-state-)

---
#### MAKEFILE Usage: 

Setting up the project:
```bash
> make init
```
  
Generating a Win32 application program entry-point, run:
```bash
> make Win32
```

To compile the application in debug mode, run:
```bash
> make all
```
Alternatively, run
```bash
> make win
```

To compile the program in release mode, run:
```bash
> make app
```
To create a project LOG file, run:
```bash
> make LOG
```
---
#### Unicode Macro Definition

The following macros are defined by default when compiling with `make win` or `make app`:
  
```cpp
#ifndef UNICODE
#define UNICODE
#endif  

#ifndef _UNICODE
#define _UNICODE
#endif
 ```

 ---

##### Example Commands:

To clean up the project, run:
```bash
> make clean
```

To generate documentation for the source code, run:
```bash
> make doxygen
```

--- 
#### Git Instructions for Repository Setup:

To commit to the repository:
```bash
> echo "# MakeFileC-Win32RecursiveLibLinkXLambdaJupyterDoxyXeusClingProject" >> README.md
> git init
> git add README.md
> git commit -m "first commit"
> git branch -M main
> git remote add origin git@github.com:lambdadotjoburg/MakeFileC-Win32RecursiveLibHeaderFileLinkXLambdaJupyterDoxyXeusClingProject.git
> git push -u origin main
```
---

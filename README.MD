## Win32 makefile application quick-setup library (automating Win32 programming)

## MakeFileC-Win32RecursiveLibHeaderFileLinkXLambdaJupyterDoxyXeusClingProject

<p>
This is a Win32 quick-project launch/setup/init makfile library management system & user guide on how to implement project-related task-management while programming Win32 & C++ & to write/build clean & efficient project & maintainable large-scale "production-quality" applications using a single makefile setup of instructions/recipes/MACROS's/command for easy deployment with Win32 Programming & maintains a simple C++ object-oriented style of programming & application-design interface integration by utilizing MACRO principles & emphasizes a programmer-centric point-of-view for developing applications ["inexperienced-programmer-friendly"]. This library is an automation toolchain component for abstracting away pedantic code-related complexity from the programmer & provides a simple (multi-layer) quick-setup/launch configuration file for "getting the job done easy" without much hassle/complications/complexities/difficulty & "petty" project-related detail!
</p>

<h3>Win32 Resources:</h3>
 
<a href="http://www.winprog.org/tutorial/start.html">The Forget's Win32 Program Tutorials</a> <br>
<a href="https://cplusplus.com/forum/articles/16820/#google_vignette">Making Win32 API Being Unicode Friendly - LPWTFISALLTHIS</a> <br>
<a href="https://www.transmissionzero.co.uk/computing/win32-apps-with-mingw/">Transmission Zero - Building Win32 GUI Applications with MinGW</a> <br>
<a href="https://learn.microsoft.com/en-us/windows/win32/learnwin32/managing-application-state-">Managing Application State - An Object Oriented Approach for coding Win32</a> <br>

### MAKEFILE usage:

<code>
This file contains the `main` entry point of the program
& serves as a stub code block for quick-setup using
a makefile => to produce this code block, run `make init`
from the command line, which will NOT overwrite
an existing main.cpp file
<code>

<p>
Compiling the program in debug mode using makefile <br>
`> make init`
</p>

Running `make win` above is equivalent to running `make init` below
with the distinction of which entry-point would the programmer/developer
like to have for their program, i.e. console/GUI

<p>
Compiling the program in debug mode using makefile <br>
`> make win`
</p>

<p>
Compiling the program in release mode using makefile <br>
`> make release`
</p>

<p>
Compiling the program on the command line with debug console <br>
`> g++ main.cpp -o main.exe -D UNICODE -D _UNICODE -municode -other-linker-options`
</p>

<p>
Compiling the program on the command line as Win32 GUI program <br>
`> g++ main.cpp -o main.exe -D UNICODE -D _UNICODE -municode -mwindows`
</p>

<p>
The below `MACRO`'s are only to be defined
when compiling as a `UNICODE` build <br>
It's possible, but unnecessary to define
a recipe in a makefile to toggle between
`ANSI` & `UNICODE` builds
</p>

<p>
`makefile` passes in the following commands: `-D UNICODE -D _UNICODE` <br>
Thus, there is no need to define the `UNICODE` & `_UNICODE` `MACRO`'s here ... <br>
The `MACRO`'s are left here as comments, nonetheless ...
</p>

define `UNICODE` `MACRO` before importing `<Windows.h>` header <br>
 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{.cpp}
	#ifndef UNICODE
	#define UNICODE
	#endif

	#ifndef _UNICODE
	#define _UNICODE
	#endif
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

makefile => Win32 Application Launch Instructions for easy/quic-project setup

i.e. "quicklaunch"/"guide"/"how-to" instruction 

Win32 Programming Library for simplifying Win32 Programming

& overall-ALL Win32 & WinAPI WinMain() WinMainW() FULLY DOCUMENTED & 

& DO STUFF ...

This is a project automation toolchain technology that abstracts
the intricacies/complexities of C++ programming & allow's for simplistic Win32 application programming!

THIS IS A "MUST-KNOW" HOW-TO "Start-up" guide/walkthrough on

	"HOW TO PROGRAM using Win32 API & simple programming experience
	having project-scalability in mind for growing-while-maintaing
	project-related-dependencies by minimalizing the programmers needs,
	yet maintain user-flexibility & project intricacies & user-centric & programmer-centric needs into consider/account/

	in a unique design principle/architecture design/overall-programming/user-experince programmer-centric Win32 C++ Object Oriented ToolChain SetOfTechnologies!
"CORE" LIBRARY FEATURES THAT A PROJECT "MUST HAVE"

BUILDING A SIMPLE WIN32 Win#@ X86 Prog32 64 WinMain WinMainW WinMainA applications AUTOMATION-TOOL-chain Library "setup" project & TOOL-CHAIN automation project

for utilizing/exploiting C++ language features for building & automating the project automation project "industrial quality"/"highly-scalable"/"project-design"-oriented

i.e. with FOCUS on the PROGRAMMER's NEEDS Rather than the over-all COMPUTER-TASKS & other non-functional-driven libraries.

i.e. this project library "borrows" concept (inter-disciplinary) between related-scientific

as-well-as corporation/business/product-output needs for building large scalable applications with minimalistic needs/requirements from the programmer!

i.e. this `Library`` is an `interface`` (a pretty decent one  =>I must admit!) AN INTERFACE BETWEEN Win32 & the Programmer, i.e. the Inexperienced Programmer!

i.e. this `Library is a stand-alone` & integration software to other existing projects,

i.e. this `Library`/Project` "automates" the programming-aspects around programming Win32 Application in the simplest/"most-elegant" way!

i.e. this `Project` is a reliable design for large-scalable applications using C++

as code language focus & abstracting the project automation around C++ programming including RELIABLE/OFFICIAL Internet Resources!

object-Oriented programmer-centric & developer-oriented/programmer-point-of-view task-automation tool-chain Win32

i.e. This is a library that focusses on ...

... the developer's/programmer's "point-of-view" 
... MACRO instructions & recursive makefile automation
... program compilation toolchain
... Win32 programming & tech-stack expansion/integration

/RECIPE'S
# /MAKEFILE
# /DOXYGEN
# /C++
# /Xeus-Cling
# /Win32 integration Library 
# Software integratopm Win32 application integration software
# & frame-work integration software for automating Win32 Programming
# & Makefile & other SIMILAR TECHNOLOGY INTEGRATION softwareS!!!
# This `Library` is a ROBUST ENGINE TO AUTOMATE Win32
# & makefile-related & Recursive-Project BUILD instructions
# for AUTOMATING Win32 Programming Experience
# & Integrating WITH THE COM TOOLCHAIN IN THE MOST ROBUST
# SIMPELST/MOST-ELEGANT/POSSIBLE/WAY/LibrarySoftwareSystem!"

# This is a Win32 Project BUILD FRAMEWORK

# This is the "worlds" simplest"/"most-user-friendly" Win32 Project Library FRAMWRORK

# This file contains instructions for building Win32 applications with minimal "effort"

# This project is a programming & design tool-chain library for Win32 "easy-setup"

# & "getting started" in the SIMPLEST WAY POSSIBLE TO become a Win32 "Programming"

# EXPERT in the shortest/least amount of time required/as possible!"

# This Library serves as a "Game-ENGINE" CORE Abstraction-Layer FROM SIMPLIYING PROGRAMMING COMPLEXITIES & 

# FOR building Prog Win32 Applications & the "cleanest" "simplest" way possible

# This DOCUMENT's interpretation may jump from concepts accross discplines, that i.e. programming to architecture/project-configurations/settings/tool-chain-design as well ...

=> BUT THE USER of the Library is NOT "hindered" in the "simplest sense" by having to learn "abstract complexities"

=> 

about the overall Win32 Programming Architecural Experience!

// MORE ROBUST FRAMEWORK & Simplificatation & Project/Win32 design/project-build process!

LIBRARY X-Lambda TOOLCHAIN for integrating your projects with the Win32 API COM In the "simplest" "most elegant" "sense of the word"

	& the simplest/most-minimalistic "sense" easy-design experience! & Win32 Project-BUILD SETUP

		& makefile instructions for automating the project-build & programming experience!

			& This library is an "easy-to-learn" => "beginners guide"

			on "how to automate the programming design experience

				to abstract non-experienced developer's needs"

		This project build process & programming "tutorial" series
    & over-all programming automation-toolchain for WIn32API easy-integration
    & quick-setup instructions file

We include all the simplest mechanisms & describe how each can be used for simplifying & automating the user's task while interacting with some of the complexities of C++ & other complicated programming concepts, while using loops & simple programming functionality to automate computer instructions ALL THE WHILE Maintaining Project-build 

// & simplication for both user & developer "design"/architectural quick-setup Win32 Library TOOLCHAIN in

from learning C++ Object Oriented 

THIS FILE PROVIDES INSTRUCTIONS FOR THE SIMPLICATION OF BUILDING AESTHETIC WIN32 APPLICATIONS!

& SIMPLE WIN32 Win#@ WinMain() main() WinMainW() & WinMainA() style projects & Simplifying "mundane"/routine/&complexities

i.e. "HIDING" the "distinction" between the three different functions

	invokations := list<function> { Win32(), winMain WinMain(), WinMainW(), }" // "API" 'library'	

i.e. 

tasks/i.e. eliminating dependencies on other libraries at maximal "ability"

This Library is a simplication of building highs-scalable Prog Win32 Applications in a simple makefile demo!

This is a `Library` FILE:

This is a quick-start "guide" on "how to get started" with the "best"

windows programming tool-chain for automating Win32 Application DESIGN!


i.e. This FILE if understood/interpreted correctly, will demonstrate the user/client

of the @software at which 

i.e. DOCUMENTATION that describes how the Win32 API Library integrates fairly straight-forwardardly

to the computing/computation device

AN ABSTRACT-LAYERING to "Simplify & Automate the Win32 Programming & GAME-Engine & Application-Software & Simulations Process"

& abstracting away from all the underlying system call's Win32 Program Library & other cumbersome/mundane/routine tasks is left for the machine!

"Simplifying" the Win32 Program EXPERIENCE PROVIDING ALL INSTRUCTIONS IN A SINGLE makefile project compilation (series)

The project is easy to launch, i.e.

a single makefile is executed on by striaght-forward calls like 'run make' or `make-all` or `make init` or `make file` or `make documentation` or `make x ` wher x = <system-call>

Simple/plain-English core-library that simplifies the Win32 C++ Object Oriented Programming experience

automating the project "build process" for broadcasting/automating the "deployment process" for 

building "good quality" applications ...

a larger quintity/scalable application Win32 C++ Object Oriented Programming Framework

that integrates near-flawlessly for Building "LARGE-SCALE PROJECT"

& Automating the process using the MACRO-Design

	& application & implementation of code programming design "principles"
  for building scalable applications using Win32 & the GNU toolchains
  for automating/simplifying the programming/delevoping experience

The project is a single makefile-that incorporates programmer 

& documentation automation process using all related projects & internet experiences like integrating with XeuxClingX++Library integration Software & Project Automation-TOOLING & "PROJECT-SIMPLIFICATION LIBRARY SOFWARE of " arguably the BEST SOFTWARE DESIGN PATTERN (DOCUMENTATION & BUILD INSTRUCTIONS RECORDED ALSO During `.this` project "under discussion"!)

* "old-school style" programming

* internet resources that support good Win32 application programming

* the Documentation of Win32 LambdaX "quick-build & easy-launch" project SETUP INSTRUCTIONS & seamless integration with various technology platforms/toolchains:

A WINDOWS WIn32 API LIBRARY FRAMEWORK FOR BUILDING

	"Large-Scale Application PROJECT AUTOMATION INSTRUCTIONS

		Like: WinMain() & main() system Function Calls" API

This is a "Library" X-&lamb;ambda

Application SOFTWARE DESIGN for Automating Documentation for your Win32 Application "BUILD"

i.e. Enhancing the C++ "developing experience"! which is "known in the application-design-community" as quite a bit of a tricky problem to solve, but is actually quite easy,
as you shall learn if you keep reading on ...

@next @Paragph!

C++ "short-story"

Library for automating Win32 Programming, which is "understood"
to be a notoriously complicated build framework to "Work ON"
but EXTREMELY PROVERFUL TO IMPLEMENT THE FIRST TIME

a Win32 MicroSoft Window's X 2000's plus series automation library for building Win32 Applications WHILE AUTOMATING THE DOCUMENTATION!

RECORDED DEMO VIDEOS for release on having one of the simplest makefiles in humna existence for automating "boring" comp

 "rabbit-hole" => 


The "arguably simplest" `makefile` you'll ever need for building windows framework C++ Win32 API Programs


The "arguably simplest" `makefile` you'll ever need for building windows framework C++ Win32 API Programs
& `makefile` syntax reader/interpreter framework/ that build's default start-up projects quick setup quides
& how-to's on using simple makefile instructions, like `make run` & make all` & make run init` & make run setup`
installation user's guide for Quick Win32 Project Setup auto-complete project & documentation automation!
performs routine tasks in background via makefile instrcution/recipe such as task `clean-up` &
`back-up` restore points & `project settings` & preferences all in a single makefile
project => to automate simple `quick-setup` for building mini Win32 Projects => a quick-start guide
on using the makefile` recipes to automate mundane tasks for setting up Win32 API
Instructions (A Win32 project application-setup library & generates
"system calls" & limit's programmer's responsibilities for interaction
with Win32 `makefile` "garbage" (also understood as "project cleanup" & documentation maintenance) "mundane developer"
C++ operations & limit's programmer's )
Documented from Multiple Internet Resources & Embedded by

& `makefile` syntax reader/interpreter framework/ that build's default start-up projects

"quick setup"

guide/quick-setup & how-to's

on "HOW-TO"

using simple makefile instructions, like `make run` & make all` & make run init` & make run setup` installation user's guide for Quick Win32 Project Setup auto-complete project & documentation automation! performs routine tasks in background via makefile instrcution/recipe such as task `clean-up` & `back-up` restore points & `project settings` & preferences all in a single makefile project => to automate simple `quick-setup` for building mini Win32 Projects => a quick-start guide on using the makefile` recipes to automate mundane tasks for setting up Win32 API Instructions (A Win32 project application-setup library & generates system calls & C++ operations & limit's programmer's )
Documented from Multiple Internet Resources & Embedded by
# git INSTRUCTIONS for commit to REPO

[generating an ssh key for github secure protocol interface](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

[setting git username & user email for git conig](https://stackoverflow.com/questions/37805621/change-email-address-in-git)

<code>
  echo "# MakeFileC-Win32RecursiveLibHeaderFileLinkXLambdaJupyterDoxyXeusClingProject" >> README.md
  git init
  git add README.md
  git commit -m "first commit"
  git branch -M main
  git remote add origin git@github.com:lambdadotjoburg/MakeFileC-Win32RecursiveLibHeaderFileLinkXLambdaJupyterDoxyXeusClingProject.git
  git push -u origin main

  git remote add origin git@github.com:lambdadotjoburg/MakeFileC-Win32RecursiveLibHeaderFileLinkXLambdaJupyterDoxyXeusClingProject.git
  git branch -M main
  git push -u origin main
<code>

# git INSTRUCTION for commit to REPO (PSEUDO-CODE)

> create README.md FILE <br/>
> git add README.md
> write a message for the project commit
> configure the repo for main branch target
> push the source code base to the main branch
> add origin/github repo url
> push to the man branch

LONG PATH Names causing git-related problems:

git ERRORS & project publish & release FATALITIES:

> git add fata:pathspec XXX did not match any files

git unable to index file failure:

> error: unable to index file

[Windows git "warning: LF will be replaced by CRLF", is that warning tail backward?](https://stackoverflow.com/questions/17628305/windows-git-warning-lf-will-be-replaced-by-crlf-is-that-warning-tail-backwar)

> git config --global core.autocrlf false

git FATAL ERROR:

01_ReleaseVersion/Hist/08_SnapShot_Version/BackupRestorePointWin32ProjectSetup/CompilationLibraryWin32AutomationToolChainProject/WindowsProgrammingIsHARDWin32WinWinMain/MakeFileProject/doc/html/dir_0754edb2a82a27d87c54d3346d1cdb2b.html

> fatal: adding files failed

01_ReleaseVersion/Hist/08_SnapShot_Version/BackupRestorePointWin32ProjectSetup/CompilationLibraryWin32AutomationToolChainProject/WindowsProgrammingIsHARDWin32WinWinMain/MakeFileProject/doc/html/dir_0754edb2a82a27d87c54d3346d1cdb2b.html


## Win32 makefile application quick-setup library (automating Win32 programming)

  

##### MakeFileC-Win32RecursiveLibLinkXLambdaJupyterDoxyXeusClingProject

  

* C++

* Win32

* MAKEFILE

* DOXYGEN

* Xeus-Cling

  

<p>

This is a Win32 quick-project launch/setup/init makefile library management system & user guide on how to automate project-related & task-management processes while programming Win32 & C++ to write/build clean & efficient code & maintainable large-scale "production-quality" applications using a single makefile setup of instructions/recipes/MACROS's/command for easy deployment with Win32 Programming. <br/>

The projects assists programmers to maintain simple-yet-powerful "high-quality"/scalable C++ applications/projects & provides developer-centered interfaces for easy-deployment/quick-setup/how-to-style instructions ["inexperienced-programmer-friendly"] with focus on project maintainance, by utilizing MACRO principles <br/>

This library is an automation toolchain component for abstracting away pedantic/"petty" project-related complexities/intricacies & provides a simple (multi-layer) interface,

including quick-setup/launch/easy-deploy & configuration files for "getting the job done easy" without much hassle/jumping over hurdles & simplifying other project-related detail! <br/>

</p>

  

<h3>Win32 Resources:</h3>

<a  href="http://www.winprog.org/tutorial/start.html">The Forget's Win32 Program Tutorials</a>  <br>

<a  href="https://cplusplus.com/forum/articles/16820/#google_vignette">Making Win32 API Being Unicode Friendly - LPWTFISALLTHIS</a>  <br>

<a  href="https://www.transmissionzero.co.uk/computing/win32-apps-with-mingw/">Transmission Zero - Building Win32 GUI Applications with MinGW</a>  <br>

<a  href="https://learn.microsoft.com/en-us/windows/win32/learnwin32/managing-application-state-">Managing Application State - An Object Oriented Approach for coding Win32</a>  <br>

  

#### MAKEFILE usage:

  

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

  

define `UNICODE`  `MACRO` before importing `<Windows.h>` header <br>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{.cpp}

#ifndef UNICODE

#define UNICODE

#endif

  

#ifndef _UNICODE

#define _UNICODE

#endif

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<p>
makefile => Win32 application quick-launch/easy-deploy instructions <br/>
for easy/quick project-setup, i.e. "quicklaunch"/"guide"/"how-to" instruction
</p>

<p>
Win32 Programming Library for simplifying Win32 programming project maintainance <br/>
& overall-ALL Win32 & WinAPI WinMain() WinMainW() stub code for quick-project deployment
</p>

<p>
FULLY (auto)-documented project management FRAMEWORK/Library
</p>

<p>
This is a project automation toolchain component/technology that abstracts <br/>
the intricacies/complexities of C++ programming & allow's for simplistic <br/>
Win32 application programming!
</p>

<p>
THIS IS A "MUST-KNOW"/"HOW-TO" "start-up"/"guide"/"walkthrough" on <br/>
"HOW TO deploy Win32 application & the FRAMEWORK provides a simple/elegant <br/>
programming inteface/user-experience, promoting project-scalability <br/>
for easy long-term project-maintainance & minimizes pre-requisite project expertise <br/>
by simplifying the programmers project-workflow yet maintains user-flexibility <br/>
& project intricacies & promotes a user-centric & programmer-centric point-of-view <br/>
with a unique overall design architecture design, mainly for building Win32 C++ <br/>
object Oriented-style software technologies.
</p>

<p>
"CORE" LIBRARY FEATURES:
</p>

This file contains the `main` entry point of the program
& serves as a stub code block for quick-setup using
a makefile => to produce this code block, run `make init`
from the command line, which will NOT overwrite
an existing main.cpp file

### This is an X-&lambda;ambda C++ "short-story"
  

* Deploying simple Win32 GUI `WinMain`, `WinMainW` & console `main` applications start-up stubs
* AUTOMATION toolchain "setup" project & documentation automation toolchain => techstack expansion/evolution/integration
* utilizing/exploiting C++ language features for building & automating the project automation project
* "industrial quality"/"highly-scalable"/"project-design"-oriented

<p>
i.e. with FOCUS on the PROGRAMMER's NEEDS Rather than the over-all COMPUTER-TASKS & other non-functional-driven libraries. <br/>
i.e. this project library "borrows" concept (inter-disciplinary) between related-scientific <br/>
as-well-as corporation/business/product-output needs for building industrial-scale <br/>
applications that are flexible & scalable with minimal pre-requisites <br/>
</p>

* This `Library` is a minimalistic `interface` between Win32 source code & programmer/developers <br/>
* This `Library` is a `stand-alone` & tech-stack software integration tool for simplifying project maintainance <br/>
* This `Library`/Project` "automates" the programming-aspects around programming Win32 Application in the simplest/"most-elegant" way! <br/>
* This `Project` is a reliable for small/medium/large-scale applications
* This `Project` uses C++ as core programming language to automate project maintainance enabling programmers'/developers' to focus on "what's important"
* This `Project` enhances Object-Oriented principles & promotes a programmer-centric & developer-oriented point-of-view by providing project-automation tools!
* This is a library that focusses on the following core features ...

<p>
<space><space><space>... minimalistic project layout & design/architecture<br/>
<space><space><space>... developer-centric/programmer-centric "point-of-view"<br/>
<space><space><space>... MACRO instructions & recursive makefile automation<br/>
<space><space><space>... program compilation toolchain & simplifying compiler linking<br/>
<space><space><space>... Win32 programming & tech-stack expansion/integration<br/>
<p>

<p>
Software integration Win32 application integration framework/software <br/>
for automating Win32 Programming & `makefile` <br/>
& integration/expansion into other related technologies <br/>
This `Library` is a ROBUST ENGINE TO AUTOMATE Win32 <br/>
& makefile-related & Recursive-Project BUILD instructions <br/>
for AUTOMATING the Win32 Programming Experience <br/>
This `Project` is designed for building ROBUST COM-interoperable projects <br/>
in the SIMPELST/MOST-ELEGANT/POSSIBLE/WAY/in the most general sense <br/>
</p>

<p>
This is a Win32 Project BUILD FRAMEWORK
This is the "worlds" simplest"/"most-user-friendly" Win32 Project Library FRAMWRORK
This file contains instructions for building Win32 applications with minimal "effort"
This project is a programming & design tool-chain library for Win32 "easy-setup"
& "getting started" in the SIMPLEST WAY POSSIBLE TO become a Win32 "Programming"
EXPERT in the shortest/least amount of time required/as possible!"
This Library serves as a "Game-ENGINE" CORE Abstraction-Layer FROM SIMPLIYING PROGRAMMING COMPLEXITIES & for building Prog Win32 Applications & the "cleanest" "simplest" way possible
This DOCUMENT's interpretation may jump from concepts accross discplines,
that i.e. programming to architecture/project-configurations/settings/tool-chain-design as well ...
<p>

<p>
THE USER/CLIENT/programmer/developer is NOT "hindered" by a steep learning curve, having to learn project-related "abstract complexities"
The programmer is thereby provided a simple/minimalistic programming interface for deploying C++/Win32 applications in little-to-no-time
</p>

<p>
LIBRARY X-Lambda TOOLCHAIN for integrating your projects with the Win32 API COM In the "simplest"/"most elegant" way possible ... <br/>
<space><space><space> & the simplest/most-minimalistic design using the Win32 Project-BUILD SETUP/QUICK-LAUNG/EASY-DEPLOY <br/> 
<space><space><space><space><space> makefile recipes/instructions/commands for automating the project-build & programming experience! <br/> 
<space><space><space><space><space><space> & This library is an "easy-to-learn"/low-learning-cureve => "beginner-friendly" <br/>
<space><space><space><space><space><space> on "how to automate the programming design experience
<space><space><space><space><space> to abstract non-experienced developer's needs"
<space><space><space> This project build process & programming "tutorial" series
<space><space> & over-all programming automation-toolchain for WIn32API easy-integration
<space><space> & quick-setup instructions file
</p>

<p>
We include all the simplest mechanisms & describe how each can be used for simplifying
& automating the user's task while interacting with some of the complexities of C++
& other complicated project-related concepts while the client may focus on application logic
<br/>
<space><space><space><space><space>... ALL THE WHILE Maintaining Project-build integrity, scalability & felxibility ...
</p>

<p>
From learning C++ Object Oriented coding to Win32 Hungarian-Notation & project-deployment, <br/>
THIS FILE PROVIDES INSTRUCTIONS FOR A MINIMALISTIC PROJECT & BUILDING AESTHETIC Win32 APPLICATIONS!
</p>

<p>
This `Library` abstracts away from `Win#@` `WinMain()` `main()` `WinMainW()` </br>
& `WinMainA()` style projects & entry points & simplifying <br/>
"mundane"/routine/MACRO-like tasks such as setup & project pre-requisite steps ... </br>
i.e. "HIDING" project-structure related tasks for programmers to focus on core programming </br>
<br/>
invokations := list<function> { `winMain()` WinMain(), WinMainW(), }" // "API" 'library'
</p>

<p>
This is a quick-start "guide" on "how to get started" with the "best" <br/>
windows programming tool-chain for automating Win32 application DESIGN! <br/>
i.e. provided the instructions in this FILE is understood/interpreted correctly!
</p>

<p>
This DOCUMENTATION contains straight-forwardard instructions for deploying <br/>
& building minimalistic Win32 applications/programs/projects to the computing/computation device
</p>

This project provides an ABSTRACT "LAYER" to simplify the project-build experience & automate some Win32-setup procedures <br/>  

The makefile containes simple recipes/commands/instructions like ... <br/>

<code>
> 'run make' <br/>
> `make all` <br/>
> `make Win32`<br/>
> `make win` <br/>
> `make doxygen`<br/>
> `make x` where `x` represents a pre-defined makefile macro <br/>
</code>

For a list of ALL make recipes, run `make help`

<p>
Simple/"plain-English" core-library that simplifies the Win32/C++ object-oriented programming experience <br/>
all-the-while automating the project "build process" for compilation, documentation & project deployment/broadcast <br/>
building "good quality" applications with minimal effort & integrates flawlessly with existing techn-stacks for building "LARGE-SCALE" PROJECT <br/>
<p>

* "old-school" style programming
* simple makefile for eliminating "boring" project-administration
* internet resources that support good Win32 application programming design
* documentation of Win32XLambda "quick-build/quick-launc/quick-setup/easy-deploy"
* seamless integration with various technology toolchains & platforms
* enhancing C++ object-oriented style programming source code & architecture
* automating Win32 programming, yet maintaining flexibility, inter-operability & serves as an EXTREMELY PROVERFUL TOOL
* Win32 MicroSoft Window's X 2000's plus series automation library for building Win32 applications WHILE DOCUMENTING THE PROJECT!
* RECORDED DEMO VIDEOS included project build & launch/release
<p>

The "arguably simplest" `makefile` you'll ever need for building windows framework C++ Win32 API Programs <br/>
& `makefile` syntax reader/interpreter framework/ that build's default start-up projects quick-setup/easy-deploy <br/>
& how-to's on using simple makefile instructions, like ... <br/>
</p>

* Backup restore point
* log-file management
* project settings
* user-preferences & configurations
* quick-setup/quick-start/easy-deploy/ ... => all in a single makefile

project => to automate simple for building mini Win32 Projects => a quick-start guide
on using the `makefile` recipes to automate mundane tasks for setting up Win32 API
Instructions (A Win32 project application-setup library & generates
"system calls" & limit's programmer's responsibilities for interaction
with Win32 `makefile` "garbage" (also understood as "project cleanup" & documentation maintenance) "mundane developer" C++ operations & limit's programmer's )
Documented from Multiple Internet Resources & Embedded by
</p>

#### git INSTRUCTIONS for commit to REPO  

[generating an ssh key for github secure protocol interface](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)  

[setting git username & user email for git conig](https://stackoverflow.com/questions/37805621/change-email-address-in-git)  

<code>
> echo "# MakeFileC-Win32RecursiveLibHeaderFileLinkXLambdaJupyterDoxyXeusClingProject" >> README.md <br/>
> git init <br/>
> git add README.md <br/>
> git commit -m "first commit" <br/>
> git branch -M main <br/>
> git remote add origin git@github.com:lambdadotjoburg/MakeFileC- Win32RecursiveLibHeaderFileLinkXLambdaJupyterDoxyXeusClingProject.git <br/>
> git push -u origin main <br/>
> git branch -M main <br/>
> git push -u origin main <br/>
</code>

  

#### git INSTRUCTION for commit to REPO (PSEUDO-CODE)  

<code>
> create README.md FILE <br/>
> git add README.md <br/>
> write a message for the project commit <br/>
> configure the repo for main branch target <br/>
> push the source code base to the main branch <br/>
> add origin/github repo url <br/>
> push to the man branch <br/>
</code>

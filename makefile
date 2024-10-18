# https://www.youtube.com/watch?v=DtGrdB8wQ_8

.RECIPEPREFIX=>

# # project name
# PROJECT_NAME=Project Name ...

# No need to change the below
BINARY=main
ROOT=.
BUILDDIR=build
# default is debug => bin/debug
# release mode => bin/release
# OUT=bin/debug
BIN=bin
OUT=$(BIN)/debug

# The only variables that would ever really need to be changed
# for project specific requirements is the below INCDIRS variable
# in case the makefile user/clinet would like to add/remove folders
# that contain project-dependent .h header files

# This is the only list of folder paths that
# really ever needs to be updated manually
# INCDIRS=./src/inc/ #./Alt/Sub/ # list additional include .h header file directories here ...

# Next, we will automate INCDIRS, so that makefile can discover 
INCDIRS=$(sort $(dir $(call rwildcard $(ROOT)/*/)))

# The following DIRS variable stores default directories to be create with `make init`
# src will be used to store all the project source files
# src/lib contains the actual project source code files having extension .cpp
# src/include contains the header files having extension .h
# bin will be used to store the compiled executable program in either debug or release subfolder/subdirectory
# doc will be used to store the doxygen generated documentation files for the project
# doc/cstmz will be used to store customized doxygen generated documentation
# extern will be used to store any shared object .so & dynamically linked library .dll files external to the project
DIRS= src/lib src/inc bin/debug bin/release doc/log doc/cstmz/html extern/dll extern/lib
# add any additional directories to be created for project-specific folder hierarchy requirements

PROJ_NUM = 0.0.0 # prompt user for this details during init/setup
COMPANY_NAME=&lambda;ambda

# compilation flag options:
# https://caiorss.github.io/C-Cpp-Notes/compiler-flags-options.html#org3aa59c3

EXT=cpp
CXX=g++ # don't change CXX (in debug mode)
STD=-std=c++11

# define compiler optimization level
# toggle between -O0 -O1 -O2 -O3 & some others
OPT=-O0
DEPFLAGS=-MP -MD

# DEPFLAGS Details:

# -MP:
# 
# This option instructs CPP to add a phony target for each dependency other
# than the main fle, causing each to depend on nothing.
# These dummy rules work around errors make gives
# if you remove header fles without updating
# the ‘Makefile’ to match
#
# -MD:
#
# The driver determines fle based on whether an ‘-o’ option is given.
# If it is, the driver uses its argument but with a suffixx of ‘.d’,
# otherwise it takes the name of the input file,
# removes any directory components and sufx,
# and applies a ‘.d’ suffix
#

WARNFLAGS=-Wall -Wextra
DEBUGFLAGS=$(WARNFLAGS) -DDEBUG -g

FLAGS=-C $(STD) $(foreach D, $(INCDIRS), -I$(D)) $(DEPFLAGS) $(OPT) # append to this (in debug mode)

# Stack Overflow post for recursive wildcard function:
# https://stackoverflow.com/questions/4036191/sources-from-subdirectories-in-makefile
# https://stackoverflow.com/questions/3774568/makefile-issue-smart-way-to-scan-directory-tree-for-c-files
# define a recursive wildcard function to compile files in subdirectories in a recursive manner!
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

# https://blog.jgc.org/2011/07/gnu-make-recursive-wildcard-function.html
# https://stackoverflow.com/questions/2483182/recursive-wildcards-in-gnu-make
# rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))
# To find all the C files in the current directory:
# $(call rwildcard,.,*.c)
# # To find all the .c and .h files in src:
# $(call rwildcard,src,*.c *.h)

FILES:=$(sort $(call rwildcard,$(ROOT)/,*.$(EXT)))

# define the directory that stores dynamically linked library files ...
# The extern directory is searched recursively, so any fildes in subfolders are also included ...
# Folders containing .dll files MUST be stored in the extern folder
DLL_EXT=dll # on unix, change this to .so or .a
EXTERN_DIR=$(ROOT)/extern
DLL:=$(basename $(sort $(notdir $(call rwildcard,$(EXTERN_DIR)/,*.$(DLL_EXT)))))
# This is done so that we can append -l to the library name, like -llibname to include the .dll files during linking

# https://stackoverflow.com/questions/7826448/linking-libraries-with-gcc-order-of-arguments
# SUB=$(sort $(dir $(call rwildcard $(EXTERN_DIR)/*/)))
SUB=$(dir $(sort $(call rwildcard,$(EXTERN_DIR),*)))
# append the Folder/Directory to search for .dll's using -LdllFolderName
# LINKER_FLAGS = -L$(ROOT)
# LINKER_FLAGS=-L$(EXTERN_DIR)
# Example LINKER_FLAGS:
# Suppose sub_file.cpp depends on alt_file.cpp, then ...
# -L./extern/sub -lsub_file.cpp  -L./extern/alt -lalt_file.cpp
# Example usage:
# g++ main.cpp -o main.exe -L./extern/sub -lsub_file.cpp  -L./extern/alt -lalt_file.cpp
LINKER_FLAGS = # empty
LINKER_FLAGS += $(foreach s, $(SUB), -L$(s))
# append the -llibname to FLAGS during linking
LINKER_FLAGS += $(foreach dll, $(DLL), -l$(dll)) # append to this (in debug mode)
# CAUTION: the order of linking is important in gcc/g++
# For certain applications, the above LINKER_FLAGS may need to be hard-coded
# specifically if there is dependencies, for example:
# if a.cpp depends on b.cpp & b.cpp depends on d.cpp
# then compiling g++ a.cpp -L./dir/to/libs -ldependencies
# MUST be done in the correct order:
# g++ a.cpp -L./dir/to/b -lb -L./dir/to/d -ld
# suppose ./dir/to/b = ./dir/to/d = ./ then
# g++ a.cpp -L. -lb -ld is the only correct order!
# So LINKER_FLAGS may need to be hard-coded
# depending on the user's specific needs!

# use pattern substitution to identify .o object & .d files for linker & dependencies
OBJECTS=$(patsubst %.$(EXT),$(ROOT)/$(BUILDDIR)/%.o,$(FILES))
DEPFILES=$(patsubst %.$(EXT),$(ROOT)/$(BUILDDIR)/%.d,$(FILES))

# `debug` appears before `all` because `debug` is the "default" make recipe/command
# define the program entry point
EXE=$(ROOT)/$(OUT)/$(BINARY).exe

# https://stackoverflow.com/questions/1079832/how-can-i-configure-my-makefile-for-debug-and-release-builds
debug : FLAGS += $(DEBUGFLAGS)
debug : all ## recipe for building the binaries in debug mode (program executable .exe resides in bin/debug)

# in release mode, build the executable main.exe in bin/release
release : OUT = bin/release
release : all ## compile the application in release mode (program executable .exe resides in bin/release)
>$(COPY)
# a better way, is to create an installer for the application
# so that the program's .dll & other file/folder structure
# remains in-tact, while the PC environment PATH variable is
# set instead, so that the .dll's have a permanent location
# & the environment PATH variable is ALWAYS set to point to
# the appropriate directory containing the relevant .dll's

# still in progress ...
# define a recipe for compiling the Project to a statical library
STATIC_FLAGS= # initially empty

static : STATIC_FLAGS=-static -static-libgcc -static-libstdc++
static : release

# Experimental: # still in progress ...
# I tried to change OUT variable, depending on debug/release make flag/args

# debug : $(override $(OUT) := bin/debug)
# debug : $(eval OUT=bin/debug)
# debug : $(eval EXE=bin/debug/main.exe)

# release : override OUT = bin/release
# release : EXE = bin/release/main.exe
# release : $(eval override OUT := bin/release)
# release : $(eval OUT=bin/release)
# release : $(eval EXE=bin/release/main.exe)

# copy the .dll files over to the appropriate directory, alongside main.exe
COPY_FILES:=$(sort $(call rwildcard,$(ROOT)/,*.$(DLL_EXT)))
COPY=$(foreach file, $(COPY_FILES), $(shell cp -nf $(file) $(OUT)))
# COPY=$(foreach file, $(COPY_FILES), $(shell mv $(file) ./bin/debug/$(basename $(file).$(DLL_EXT))))

.PHONY : copy
copy:
>$(COPY)
# >$(foreach file, $(COPY_FILES), $(shell cp $(file) $(OUT)))
# >$(shell $(foreach file, $(COPY_FILES), cp $(file) $(OUT)))
# >$(shell $(foreach file, $(COPY_FILES), [ ! -f $(file) ] && cp $(file) ./bin/debug/))

# builds the binary executable for the program
all : $(BINARY) ## recipe for building/compiling the project!
# >$(COPY)
# no need to copy .dll files to folder alongside .exe executable,
# since the PATH variable is updated to include directory
# to .dll files before runtime/startup/execution of main.exe
# However, for release mode, it is still preferred to copy the .dll files

# builds the binary executable for the program
$(BINARY) : $(OBJECTS)
>@mkdir -p $(OUT)
>$(CXX) -o $(OUT)/$@ $^ $(Win32_FLAGS) $(LINKER_FLAGS)
# Note*: linking order matters, i.e.
# LINKER_FLAGS may need to be hard-coded
# depending on makefile user's specific needs!!!
# link .dll's when compiling executable
# Win32_FLAGS are empty, unless compiling
# with make app which sets this Win32_FLAGS
# variable as -mwindows

# builds the object files for each .cpp/.c
# file in the project folder hierarchy
$(ROOT)/$(BUILDDIR)/%.o : %.$(EXT)
>@mkdir -p $(dir $@)
>$(CXX) $(FLAGS) -c -o $@ $<

DIST_FOLDER=$(ROOT)/dist

clean :	## recipe for removing all object .o & dependency .d files
>rm -rf $(OBJECTS) $(DEPFILES) $(DIST_FOLDER) # $(OUT) # $(BUILDDIR)

user:
>@echo $(USERPROFILE) # \AppData\Local

# add the DLL_DIRS to the PATH
# DLL_DIRS:=$(dir $(call rwildcard,$(EXTERN_DIR)/,*.$(DLL_EXT)))

DLL_FILES:=$(sort $(call rwildcard,$(ROOT)/,*.$(DLL_EXT)))
ABS_PATH=$(dir $(foreach file, $(DLL_FILES), $(abspath $(file))))

# & we must use the recursive technique to add each
# of the paths to .dll files to the PATH variable
# at runtime, i.e. simulating runtime linking,
# while the user can keep the .dll's in a fixed
# directory/folder, i.e. no copying over the .dll files
# alongside the executable ...
# TEST_PATH_SUB=C:/Users/Lambda/Desktop/Project/extern/sub
# TEST_PATH_ADD=C:/Users/Lambda/Desktop/Project/extern/add
# C:\Users\Lambda\Desktop\Project\extern\sub
# C:\Users\Lambda\Desktop\Project\extern\add

# https://stackoverflow.com/questions/61311317/change-path-in-makefile
# export PATH := $(TEST_PATH_ADD):$(TEST_PATH_SUB):$(PATH)
DELIMITER=:
export PATH := $(foreach P,$(ABS_PATH),$(P)$(DELIMITER))$(PATH) # append P followed by colon:

env:
>$(info $(PATH))

.PHONY : run
run : ## recipe for running the program executable /.main.exe => equivalent to running ./main.exe from the command line/terminal
>@echo $(EXE)\
>[ -f $(EXE) ] && $(EXE) || echo "If the program executable $(EXE) does NOT exist => run make init to create a stub & then run make to build the executable & try again";

define PROGRAM
/**
 * @file 	main.cpp
 * @brief 	This file contains the `main` entry point of the program
 * @author 	$(COMPANY_NAME)
 * @date 	$$(date +'%Y-%m-%d %H:%M:%S')
 * @details This file contains the `main` entry point of the program
 * 			& serves as a stub code block for quick-setup using
 * 			a makefile => to produce this code block, run `make init`
 * 			from the command line, which will NOT overwrite
 * 			an existing main.cpp file
 */

#include <iostream>

/**
 * @class This is a Demo class
 * @brief This is a Demo class to demonstrate the usage of doxygen & it's use with the makefile
 * @details This Demo class is a dummy class that does not serve any purpose in the program
 * 			other than to demonstrate the usage of doxygen-style comments in the makefile
 */

class Demo {
public:
	/**
	 * @brief default constructor
	 * @details The default Demo class constructor for demonstrating doxygen & makefile
	 */
	Demo() {

	}
};

/// @brief This is the `main` entry point of the program
/// @param[in] argc The number of arguments passed in by the command line
/// @param[in] argv The argument list passed in by the command line
/// @return integer return value indicating program exit status
int main(int argc, char *argv[]) {
	std::cout << "C++ Program stub generated from makefile" << std::endl; ///< this is an inline comment
	std::cin.get(); ///< wait for user input before close console window ...
	return EXIT_SUCCESS; ///< exit statuc
	// return 0; ///< exit statuss
}

endef
export PROGRAM

# Equivalent to ./main.cpp
ENTRY=$(ROOT)/$(BINARY).$(EXT)

# recipe for initializeing new project from makefile
# I want `setup` to be dependent on `init `
.PHONY : init
init : setup
init : # run setup on `> make init` from the client/make user's perspective!
## recipe for creating all relevant project directories as needed by the makefile & creating a program stub ./main.cpp entry point
>@mkdir -p $(DIRS)
>[ -f $(ENTRY) ] && echo "If the $(ENTRY) file already exists, it will NOT be overwritten!" || echo "$$PROGRAM" >> $(ENTRY);

# Win32 program stub
define APP
/**
 * <h3>Win32 Resources:</h3>
 * 
 * <a href="http://www.winprog.org/tutorial/start.html" target="_blank">The Forget's Win32 Program Tutorials</a> <br>
 * <a href="https://cplusplus.com/forum/articles/16820/#google_vignette" target="_blank">Making Win32 API Being Unicode Friendly - LPWTFISALLTHIS</a> <br>
 * <a href="https://www.transmissionzero.co.uk/computing/win32-apps-with-mingw/" target="_blank">Transmission Zero - Building Win32 GUI Applications with MinGW</a> <br>
 * <a href="https://learn.microsoft.com/en-us/windows/win32/learnwin32/managing-application-state-" target="_blank">Managing Application State - An Object Oriented Approach for coding Win32</a> <br>
 */

/**
  * @file 		main.cpp
  * @brief 		This file contains the `WinMain` entry point of the Win32 Application
  * @author 	&lambda;ambda
  * @date		@today
  * 
  * @details 	
  * 
  * 	This file contains the `main` entry point of the program
  * 	& serves as a stub code block for quick-setup using
  * 	a makefile => to produce this code block, run `make init`
  * 	from the command line, which will NOT overwrite
  * 	an existing main.cpp file
  * 
  * <p>
  *	Compiling the program in debug mode using makefile <br>
  *	`> make win`
  * </p>
  *
  * <p>
  *	Compiling the program in release mode using makefile <br>
  *	`> make release`
  * </p>
  *
  * <p>
  *	Compiling the program on the command line with debug console <br>
  *	`> g++ main.cpp -o main.exe -D UNICODE -D _UNICODE -municode -other-linker-options`
  * </p>
  *
  * <p>
  *	Compiling the program on the command line as Win32 GUI program <br>
  *	`> g++ main.cpp -o main.exe -D UNICODE -D _UNICODE -municode -mwindows`
  * </p>
  *
  * <p>
  *	The below `MACRO`'s are only to be defined
  *	when compiling as a `UNICODE` build <br>
  *	It's possible, but unnecessary to define
  *	a recipe in a makefile to toggle between
  *	`ANSI` & `UNICODE` builds
  * </p>
  *
  * <p>
  *	`makefile` passes in the following commands: `-D UNICODE -D _UNICODE` <br>
  *	Thus, there is no need to define the `UNICODE` & `_UNICODE` `MACRO`'s here ... <br>
  *	The `MACRO`'s are left here as comments, nonetheless ...
  * </p>
  *
  *	define `UNICODE` `MACRO` before importing `<Windows.h>` header <br>
  * 
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{.cpp}
  *		#ifndef UNICODE
  *		#define UNICODE
  *		#endif
  *
  *		#ifndef _UNICODE
  *		#define _UNICODE
  *		#endif
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  * 
  */

#include <windows.h>
#include <iostream>
#include <string>

/// @brief						This is the `WinMain` entry point program stub for a Win32 App
/// @details
///     
///     `WinMain` is a `MACRO` for `WinMainW` & `WinMainA` depending on
///			whether the program is compiled as `ANSI` or `UNICODE`, respectively.
///	 		The compiler replaces `WinMain` by `WinMainW` if `UNICODE` build is selected
///			The compiler replaces WinMain by `WinMainA` if `ANSI` build is selected
///     The same is true for all variable naming conventions in Win32 API Programming
///
/// @param[in] hInstance 		  handle on Window Instance
/// @param[in] hPrevInstance 	handle on Previous Window Instance
/// @param[in] szCmdLine 		  zero-terminated string => command line arguments
/// @param[in] nCmdShow 		  number of command line arguments passed in from the console 
/// @return					        	integer return value indicating program `EXIT_STATUS`
int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR szCmdLine, int nCmdShow) {

	LPCTSTR str_ptr = TEXT("string literal");	//< Some LPCTSTR & LPWSTR stuff ...
	std::cout << *str_ptr << std::endl;		 	  //< prints first character in str_ptr
	LPWSTR cmdLineArgs = GetCommandLineW(); 	//< GetCommandLineW() retrieves a pointer to szCmdLine
	std::cout << *cmdLineArgs << std::endl;		//< dereference command line arguments

	std::cout << "Initialize App" << std::endl; /**
                                                * Also NOTE*: `TEXT("string literal")` is a `MACRO`
                                                * that compiles to `L"string literal"` in `UNICODE` mode
                                                * and compiles to `"string literal"` in `ANSI` mode
                                                */ 
	MessageBox(NULL, TEXT("Win32 Program stub generate by makefile"), TEXT("stub title"), MB_OK); //< MessageBox to display screen graphics
	// run `make win`
	// safely ignore the warning in the console for now ...
	return EXIT_SUCCESS;
}

endef
export APP

# Experimental
# Win32_FLAGS = -mwindows # define above for use in `all` directive/recipe
# UNIDOCE_FLAGS = -municode

UNICODE_FLAGS= -D UNICODE -D _UNICODE -municode

win : FLAGS += $(DEBUGFLAGS) # $(UNIDOCE_FL7AGS)
win : debug ## recipe for building the Win32 executable .exe binaries in debug mode (Windows GUI & debug console)

# in release mode, build the executable main.exe in bin/release
app : Win32_FLAGS = -mwindows
app : release ## recipe for building the Win32 executable .exe binaries in release (GUI) mode (suppressing the debug console) by passing -mwindows flag as arg to g++)

# recipe for initializeing new project from makefile
.PHONY : Win32
Win32 : ## recipe for creating all relevant project directories as needed by the makefile & creating a program stub ./main.cpp entry point for a Win32 Application
>@mkdir -p $(DIRS)
>[ -f $(ENTRY) ] && echo "If the $(ENTRY) file already exists, it will NOT be overwritten!" || echo "$$APP" >> $(ENTRY);

# recipe for listing all files files in project folder hierarchy
.PHONY : files
files : ## recipe for listing ALL relative file paths, w.r.t to ROOT directory
>@echo FILES = [${FILES}]

# define variables for all header files, having different extensions, .h .hpp .tpp
H_EXT = h
HPP_EXT = hpp
TPP_EXT = tpp
HEADERS=$(sort $(call rwildcard,$(ROOT)/,*.$(H_EXT)))
HEADERS+=$(sort $(call rwildcard,$(ROOT)/,*.$(HPP_EXT)))
HEADERS+=$(sort $(call rwildcard,$(ROOT)/,*.$(TPP_EXT)))

# recipe for listing all header files in project folder hierarchy
.PHONY : headers
headers : ## recipe for showing all .h .hpp & .tpp header files
>@echo HEADERS = [${HEADERS}]

# define a recipe that runs `clean` removes build folder & the compiled executable
.PHONY : remove
remove: clean ## recipe for removing build directory, object .o files, dependency .d files & program executable .exe
>rm -rf $(OBJECTS) $(DEPFILES) $(BIN) $(ROOT)/doc # optionally, remove $(BUILDDIR)

# define a recipe that shows all the directories in the project structure, NOT including the file names
# this is equivalent to showing all the include directories, which are ALL the project folders & sub-folders & sub-sub-folders, etc ... (recursively)
.PHONY : dirs
dirs : ## recipe for listing all directories in project folder hierarchy
>@echo INCDIRS = [${INCDIRS}]

# define a variable using rwildcard that gets all the file names in the project
NAMES=$(sort $(notdir $(call rwildcard $(ROOT)/*/)))

# define a recipe that shows the names of ALL the files in the Project Folder hierarchy, NOT including the Directory Paths
# This recipe makes use of a variable that works similar as before using the rwildcard function defined above,
# but only targets files using the `notdir` makefile directive, in place of the `dir` directive
.PHONY : names
names : ## recipe for showing ALL the names (ONLY) of the files (NOT the full path)
>@echo NAMES = [${NAMES}]

# define a whitespace token
empty:=
space:=$(empty) $(empty)

#Log data folder
LOG_DIR:=$(ROOT)/doc/log
# log info
SURNAME?=EMPTY
NAME=?EMPTY
EMAIL?=EMPTY
LOG_MSG?=EMPTY
LOG_DATE:=$(shell date '+%Y-%m-%d %H:%M:%S')
LOG_LINK:=$(subst $(space),-,$(subst :,-,$(LOG_DATE))) # replace : & whitespace by -
LOG_FILE:=$(subst $(space),,$(LOG_LINK)-log.txt) # replace any whitespace in the file name

# Target to get user input
.PHONY : LOG
LOG : ## recipe for quick project setup => 
> @read -p "Enter Surname: " sur ;\
> read -p "Enter Name: " name; \
> read -p "Enter email: " email; \
> read -p "LOG Message: " log; \
> "$(MAKE)" writelogfile SURNAME="$$sur" NAME="$$name" EMAIL="$$email" LOG_MSG="$$log";\

define LOG_ENTRY
@showdate "%Y-%m-%d %H:%M:%S" $(LOG_DATE)
<a href="../log/$(LOG_FILE)" target="_blank">
    $(LOG_FILE)
</a>
<br>
endef
export LOG_ENTRY

# a DoxyFile configuration file is a free-form `ASCII` text file with a structure that is similar to that of a `makefile`
# running doxygen -g generates a default DoxyFile/Configuration file => This makefile will use the default name DoxyFile, NOT a user-preferred name
# we do NOT want to clutter the project folder with an html & latex folder in the ROOT directory, thus, we will store the output files for doxygen in the doc folder
writelogfile : ## recipe for generating doxygen file => initialize DoxyFile configuration file
>echo "$$LOG_ENTRY" >> $(LOG_DIR)/changelog.md ;\
>echo "Date: " $(LOG_DATE) >> $(LOG_DIR)/$(LOG_FILE) ;\
>echo "Name: " $(NAME) >> $(LOG_DIR)/$(LOG_FILE) ;\
>echo "Surname: " $(SURNAME) >> $(LOG_DIR)/$(LOG_FILE) ;\
>echo "Email: " $(EMAIL) >> $(LOG_DIR)/$(LOG_FILE) ;\
>echo "LOG Message: " $(LOG_MSG) >> $(LOG_DIR)/$(LOG_FILE) ;\

# define a recipe for initializing git commands
.PHONY : git
git : ## recipe for quit .git setup
>git init
>$(info The status of the repository and the volume of per-file changes:)
>@git status
>@git diff --stat

# define a recipe for zipping the project folder for distributing the project!
# Create a .zip folder containing the redistributable source code
# DIST_FOLDER=$(ROOT)/dist
.PHONY : distribute
distribute : remove ## recipe for distributing the project source code => create a .zip folder containing project source code files
>mkdir -p $(DIST_FOLDER)
>tar.exe -a -cf $(DIST_FOLDER)/dist.zip *

# define a recipe for removing all the project folder, except the Top-Level ROOT folder
delete : # clean ## recipe for removing all the folders & files excluding the original makefile
>ls -d */ | xargs rm -rf # remove all folders/directories, not the files
>rm -rf /s /q .git # removes the hidden .git folder from project also (if any)
>rm -f $(ENTRY) # remove the REAMDE.MD file & the main.cpp file (if any)
#> rm -rf $(DIRS) $(LOG_DIR) $(README) $(ENTRY) # doc src bin
# running make clean removes the following:
# $(OBJECTS) $(DEPFILES) $(DIST_FOLDER)

# define a recipe for showing the makefile directives/recipes/target commands
# https://gist.github.com/prwhite/8168133
# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
help : ## Show makefile help.
>@fgrep -h " ##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

# https://stackoverflow.com/questions/38256738/does-gnu-make-have-a-way-to-open-a-file-using-the-default-program

README_PATH:=$(ROOT)/doc/README.md
LISENCE_PATH:=$(ROOT)/doc/legal/LISENCE.md
CSTMZ_PATH:=$(ROOT)/doc/cstmz
HTML_PATH:=$(CSTMZ_PATH)/html
WEBSITE_URL:=https://www.lambda.joburg

PROJECT_NAME ?= Project Name
AUTH_NAME ?= Author Name
PROJECT_DESCR ?= Project Description
REPO_LINK ?= REPO Link

# define a recipe for doxygen, i.e. to auto-generate documentation for the project
.PHONY : doxygen
doxygen : ## recipe for (auto)-generating documentation for project (produces updates documentation for project) run `doxygen man` to see the doxygen manual
>@echo "doxygen => (auto)-generating documentation for project ..."
>doxygen
# > Open index.html file in preferred browser => continued ...

DOXYFILE=DoxyFile
# MORE doxygen stuff ...
# To be appended to the end of DoxyFile
define DOXYGEN_CONFIGURATION_SETTINGS

#---------------------------------------------------------------------------
# User-Defined Customization Tags
#---------------------------------------------------------------------------
INPUT                  += $(ROOT)/main.cpp
INPUT                  += $(ROOT)/src
OUTPUT_DIRECTORY        = $(ROOT)/doc
RECURSIVE               = YES
FULL_PATH_NAMES         = YES
STRIP_FROM_PATH         = ..\\..
PROJECT_NAME            = $(PROJECT_NAME)
PROJECT_NUMBER          = $(PROJ_NUM)
GENERATE_TREEVIEW       = YES

#---------------------------------------------------------------------------
# Defining a `today` date ALIAS:
#---------------------------------------------------------------------------

# ALIASES 			    += today=$$(date +'%Y-%m-%d %H:%M:%S') # needs work ...

#---------------------------------------------------------------------------
# Customization for Main/Index/Home Page
#---------------------------------------------------------------------------
USE_MDFILE_AS_MAINPAGE  = $(README_PATH)
INPUT                  += $(README_PATH)

#---------------------------------------------------------------------------
# Additional .md file/pages to include
#---------------------------------------------------------------------------

INPUT                  += $(LISENCE_PATH)
INPUT                  += $(ROOT)/doc/legal/releasenotes.md
INPUT                  += $(ROOT)/doc/log/changelog.md

#---------------------------------------------------------------------------
# Technologies, Purpose, Specs, Automata .md files
#---------------------------------------------------------------------------

INPUT                  += $(HTML_PATH)/purpose.md
INPUT                  += $(HTML_PATH)/technologies.md
INPUT                  += $(HTML_PATH)/specs.md
INPUT                  += $(HTML_PATH)/automata.md

#---------------------------------------------------------------------------
# Additional Material/Getting Started .md files
#---------------------------------------------------------------------------

INPUT                  += $(HTML_PATH)/codeblocks.md
INPUT                  += $(HTML_PATH)/latex.md
INPUT                  += $(HTML_PATH)/table.md
INPUT                  += $(HTML_PATH)/tutorials.md

#---------------------------------------------------------------------------
# Dark Theme
#---------------------------------------------------------------------------

HTML_COLORSTYLE         = TOGGLE

#---------------------------------------------------------------------------
# MathJax Mathematics Rich Display Rendering
#---------------------------------------------------------------------------

USE_MATHJAX             = YES

# While we're at it, let us also include the amsmath $\LaTeX$ package
# to allow us to type $\lambda ambda$ in the `header.tex` file for the signature,
# to customize the .pdf file output even more ...

#---------------------------------------------------------------------------
# Additional Packages for LaTeX Rendering
#---------------------------------------------------------------------------

EXTRA_PACKAGES          = amsmath

#---------------------------------------------------------------------------
# html Header Customizations
#---------------------------------------------------------------------------

HTML_HEADER             = $(HTML_PATH)/header.html

#---------------------------------------------------------------------------
# html Footer Customizations
#---------------------------------------------------------------------------

HTML_FOOTER             = $(HTML_PATH)/footer.html

# Additionally, we will set the following tags.
# The first will suppress most/all of the output to the console,
# making doxygen less verbose and the second is specifically enabled
# so that we can still get important feedback about whether or not
# some of the source code has been documented or not - pretty much self explanatory!

#---------------------------------------------------------------------------
# Set Doxygen Verbosity
#---------------------------------------------------------------------------

# I would like to have some code undocumentated in certain cases => can toggle this on/off near release mode ...

QUIET                   = YES
WARN_IF_UNDOCUMENTED    = NO

endef
export DOXYGEN_CONFIGURATION_SETTINGS # necessary???

# Target to get user input
.PHONY : setup
setup : ## recipe for quick project setup => #run `setup` on `> make init`
> @read -p "Enter Project Name: " proj; \
> read -p "Enter Project Number: " num; \
> read -p "Enter Author Name: " auth; \
> read -p "Enter Project Description: " descr; \
> read -p "Enter REPO Link: " link; \
> "$(MAKE)" initdoxyfile PROJECT_NAME="$$proj" PROJ_NUM="$$num" AUTH_NAME="$$auth" PROJECT_DESCR="$$descr" REPO_LINK="$$link";\

# the above setup redirects the variables here to the initdoxyfile recipe/rule ...
# initdoxyfile :
# > @echo "$(PROJECT_NAME)";\
# > echo "$(AUTH_NAME)";\
# > echo "$(PROJECT_DESCR)";\
# > echo "$(REPO_LINK)";\

# a DoxyFile configuration file is a free-form `ASCII` text file with a structure that is similar to that of a `makefile`
# running doxygen -g generates a default DoxyFile/Configuration file => This makefile will use the default name DoxyFile, NOT a user-preferred name
# we do NOT want to clutter the project folder with an html & latex folder in the ROOT directory, thus, we will store the output files for doxygen in the doc folder
initdoxyfile : ## recipe for generating doxygen file => initialize DoxyFile configuration file
>mkdir -p $(ROOT)/doc/html;\
>mkdir -p $(ROOT)/doc/cstmz/html/;\
>mkdir -p $(ROOT)/doc/cstmz/js/;\
>mkdir -p $(ROOT)/doc/legal;\
>mkdir -p $(ROOT)/doc/log;\
>[ ! -f $(DOXYFILE) ] && ((doxygen -g $(DOXYFILE)) && (echo "$$DOXYGEN_CONFIGURATION_SETTINGS" >> $(DOXYFILE))) || echo "If the $(DOXYFILE) file already exists, it will NOT be overwritten!";\
>[ ! -f $(README_PATH) ] && echo "$$README_HTML" >> $(README_PATH) || echo "If the $(README_PATH) file already exists, it will NOT be overwritten!";\
>[ ! -f $(ROOT)/doc/cstmz/js/toggle.js ] && echo "$$TOGGLE" >> $(ROOT)/doc/cstmz/js/toggle.js || echo "If the $(ROOT)/doc/cstmz/js/toggle.js file already exists, it will NOT be overwritten!";\
>[ ! -f $(HTML_PATH)/header.html ] && echo "$$HTML_HEADER" >> $(HTML_PATH)/header.html || echo "If the $(HTML_PATH)/header.html file already exists, it will NOT be overwritten!";\
>[ ! -f $(HTML_PATH)/footer.html ] && echo "$$HTML_FOOTER" >> $(HTML_PATH)/footer.html || echo "If the $(HTML_PATH)/footer.html file already exists, it will NOT be overwritten!";\
>"$(MAKE)" generatemarkdownfiles;\

# invoke recipe for each page to be created in html directory
generatemarkdownfiles :
>[ ! -f $(LISENCE_PATH) ] && (echo "$$LISENCE_HTML" >> $(LISENCE_PATH)) || echo "If the $(LISENCE_PATH) file already exists, it will NOT be overwritten!";\
>[ ! -f $(HTML_PATH)/purpose.md ] && (echo "$$PURPOSE_HTML" >> $(HTML_PATH)/purpose.md) || echo "If the $(HTML_PATH)/purpose.md file already exists, it will NOT be overwritten!";\
>[ ! -f $(HTML_PATH)/technologies.md ] && (echo "$$TECH_HTML" >> $(HTML_PATH)/technologies.md) || echo "If the $(HTML_PATH)/technologies.md file already exists, it will NOT be overwritten!";\
>[ ! -f $(HTML_PATH)/specs.md ] && (echo "$$SPECS_HTML" >> $(HTML_PATH)/specs.md) || echo "If the $(HTML_PATH)/specs.md file already exists, it will NOT be overwritten!";\
>[ ! -f $(HTML_PATH)/automata.md ] && (echo "$$AUTOMATA_HTML" >> $(HTML_PATH)/automata.md) || echo "If the $(HTML_PATH)/automata.md file already exists, it will NOT be overwritten!";\
>[ ! -f $(ROOT)/doc/legal/releasenotes.md ] && (echo "$$RELEASE_NOTES_HTML" >> $(ROOT)/doc/legal/releasenotes.md) || echo "If the $(ROOT)/doc/legal/releasenotes.md file already exists, it will NOT be overwritten!";\
>[ ! -f $(ROOT)/doc/log/changelog.md ] && (echo "$$CHANGELOG_HTML" >> $(ROOT)/doc/log/changelog.md) || echo "If the $(ROOT)/doc/log/changelog.md file already exists, it will NOT be overwritten!";\
>[ ! -f $(HTML_PATH)/codeblocks.md ] && (echo "$$CODEBLOCKS_HTML" >> $(HTML_PATH)/codeblocks.md) || echo "If the $(HTML_PATH)/codeblocks.md file already exists, it will NOT be overwritten!";\
>[ ! -f $(HTML_PATH)/latex.md ] && (echo "$$LATEX_HTML" >> $(HTML_PATH)/latex.md) || echo "If the $(HTML_PATH)/latex.md file already exists, it will NOT be overwritten!";\
>[ ! -f $(HTML_PATH)/table.md ] && (echo "$$TABLE_HTML" >> $(HTML_PATH)/table.md) || echo "If the $(HTML_PATH)/table.md file already exists, it will NOT be overwritten!";\
>[ ! -f $(HTML_PATH)/tutorials.md ] && (echo "$$TUTORIAL_HTML" >> $(HTML_PATH)/tutorials.md) || echo "If the $(HTML_PATH)/tutorials.md file already exists, it will NOT be overwritten!";\

# INCLUDE THE FOLLOWING VARIABLES IN THE README_HTML FILE ...

# $(PROJECT_NAME)
# $(AUTH_NAME)
# $(PROJECT_DESCR)
# $(REPO_LINK)

# define html for readme.md file
define README_HTML
# Main Page {#mainpage}

<b>@showdate "%A %d-%m-%Y %H:%M"</b>
<!-- this date is generated when doxygen compiles the documenation -->

<hr/>

<h2><b>$(PROJECT_NAME)</b></h2>
<h3><b>Project Description</b></h3>
<p>
	$(PROJECT_DESCR)
</p>

developed by $(AUTH_NAME)
<a href="$(WEBSITE_URL)" target="_blank">
    $(COMPANY_NAME)
</a>

A copy of the project can be ascertained from
<a href="$(REPO_LINK)" target="_blank">
    REPO Link
</a>

<br/>

\htmlonly
    <script src="..\cstmz\js\toggle.js"></script>
    <div id="container">
        <img
            id="microchip"
            src="$(WEBSITE_URL)/assets/images/index/stock/vector_graphics/artificial_intelligence.svg"
            style="transform: rotate(45deg); display: block; margin-left: 50px;" width="100" height="100"
        />
    </div>
\endhtmlonly

<br/>

#### Here is a list of features:

- @subpage Purpose "Purpose"
- @subpage Technologies "Technologies"
- @subpage Specs "Specs"
- @subpage Tutorials "Tutorials"
        
<br/>

[Release Notes](legal/releasenotes.md)
        
@copyright <br/> [copyright & lisence agreement](legal/lisence.md)

endef
export README_HTML

# this toggle function will invert the color of the .svg files used
# that may appear dark on a dark background to appearing as inverted
# with respect to the bacgkround colors
define TOGGLE
// var toggleButton = document.getElementsByTagName('dark-mode-toggle');
// console.log(typeof(toggleButton));
// console.log(DarkModeToggle.title);
// console.log(DarkModeToggle.userPreference);
// console.log(typeof(DarkModeToggle.userPreference));
window.addEventListener('click', invert)
function invert()
{
    if (DarkModeToggle.userPreference) {
        // console.log("Dark Mode");
        document.getElementById("microchip").style.filter="invert(100%)";;
		document.getElementById("makelogo").style.filter="invert(100%)";;
    } else if (!DarkModeToggle.userPreference) {
        // console.log("Light Mode");
        document.getElementById("microchip").style.filter="invert(0%)";;
		document.getElementById("makelogo").style.filter="invert(0%)";;
    }
}
window.addEventListener("DOMContentLoaded", invert);
endef
export TOGGLE

define HTML_HEADER
<!-- HTML header for doxygen 1.9.7-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="$$langISO">
<head>
    <meta http-equiv="Content-Type" content="text/xhtml;charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=11"/>
    <meta name="generator" content="Doxygen $$doxygenversion"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!--BEGIN PROJECT_NAME--><title>$$projectname: $$title</title><!--END PROJECT_NAME-->
    <!--BEGIN !PROJECT_NAME--><title>$$title</title><!--END !PROJECT_NAME-->
    <link href="$$relpath^tabs.css" rel="stylesheet" type="text/css"/>

    <!-- the sole purpose of generating this html header file is to insert the additional favicon link below-->
    <!-- set the favicon for the browser tab -->
    <link rel="icon" href="$(WEBSITE_URL)/assets/images/index/logo/lambda_logo.svg" type="image/x-icon" />

    <!--BEGIN DISABLE_INDEX-->
      <!--BEGIN FULL_SIDEBAR-->
    <script type="text/javascript">var page_layout=1;</script>
      <!--END FULL_SIDEBAR-->
    <!--END DISABLE_INDEX-->
    <script type="text/javascript" src="$$relpath^jquery.js"></script>
    <script type="text/javascript" src="$$relpath^dynsections.js"></script>
    $$treeview
    $$search
    $$mathjax
    $$darkmode
    <link href="$$relpath^$$stylesheet" rel="stylesheet" type="text/css" />
    $$extrastylesheet
</head>

<body>
<!--BEGIN DISABLE_INDEX-->
  <!--BEGIN FULL_SIDEBAR-->
<div id="side-nav" class="ui-resizable side-nav-resizable"><!-- do not remove this div, it is closed by doxygen! -->
  <!--END FULL_SIDEBAR-->
<!--END DISABLE_INDEX-->

<div id="top"><!-- do not remove this div, it is closed by doxygen! -->

<!--BEGIN TITLEAREA-->
<div id="titlearea">
<table cellspacing="0" cellpadding="0">
 <tbody>
 <tr id="projectrow">
  <!--BEGIN PROJECT_LOGO-->
  <td id="projectlogo"><img alt="Logo" src="$$relpath^$$projectlogo"/></td>
  <!--END PROJECT_LOGO-->
  <!--BEGIN PROJECT_NAME-->
  <td id="projectalign">
   <div id="projectname">$$projectname<!--BEGIN PROJECT_NUMBER--><span id="projectnumber">&#160;$$projectnumber</span><!--END PROJECT_NUMBER-->
   </div>
   <!--BEGIN PROJECT_BRIEF--><div id="projectbrief">$$projectbrief</div><!--END PROJECT_BRIEF-->
  </td>
  <!--END PROJECT_NAME-->
  <!--BEGIN !PROJECT_NAME-->
   <!--BEGIN PROJECT_BRIEF-->
    <td>
    <div id="projectbrief">$$projectbrief</div>
    </td>
   <!--END PROJECT_BRIEF-->
  <!--END !PROJECT_NAME-->
  <!--BEGIN DISABLE_INDEX-->
   <!--BEGIN SEARCHENGINE-->
     <!--BEGIN !FULL_SIDEBAR-->
    <td>$$searchbox</td>
     <!--END !FULL_SIDEBAR-->
   <!--END SEARCHENGINE-->
  <!--END DISABLE_INDEX-->
 </tr>
  <!--BEGIN SEARCHENGINE-->
   <!--BEGIN FULL_SIDEBAR-->
   <tr><td colspan="2">$$searchbox</td></tr>
   <!--END FULL_SIDEBAR-->
  <!--END SEARCHENGINE-->
 </tbody>
</table>
</div>
<!--END TITLEAREA-->
<!-- end header part -->
endef
export HTML_HEADER

# Personalizing the Doxygen `html` Footer
# define html for lisence.md page
# The Doxygen "watermark" is contained in the `html` footer.
# So if you want to remove it for ALL auto generated `html` pages,
# then you would have to replace the `html` footer with your own personalized version.
# Thankfully, it's not to difficult - just change the details of the images, hyperlinks & wording ...
define HTML_FOOTER
        <!-- start footer part -->
        <!-- BEGIN GENERATE_TREEVIEW -->
        <div id="nav-path" class="navpath">
        <!-- id is needed for treeview function! -->
          <ul>
            $$navpath
            <li class="footer">
                &lambda;ambda
                <a href="$(WEBSITE_URL)">
                    <img
                        class="footer"
                        src="$(WEBSITE_URL)/assets/images/index/logo/lambda_logo.svg"
                        width="85" height="25" alt="doxygen"
                    />
                    <!-- src="$$relpath^doxygen.png" -->
                </a>
                <!-- $$doxygenversion -->
            </li>
          </ul>
        </div>
    </body>
</html>
endef
export HTML_FOOTER

# define code for lisence.md page
define LISENCE_HTML
# MIT Lisence {#Lisence}

<span style="color: blue;"><b>Copyright</b></span>
<a href="https://en.wikipedia.org/wiki/Copyright_symbol">&copy;</a>

<b>@showdate "%A %d-%m-%Y %H:%M:%S"</b>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

<b>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.</b>

<i><a href="$(WEBSITE_URL)">$(COMPANY_NAME)</a></i>
endef
export LISENCE_HTML

# define the technologies used in your project ...
define TECH_HTML
@page Technologies Technologies

This page contains a list of technologies used to develop the project:

<br/>

* Win32API
<a href="https://www.microsoft.com/en-gb/software-download/windows10" target="_blank">
    <img src="https://img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/RE1Mu3b?ver=5c31"
     width="200px;" style="display: block; margin-left: 50px; padding-top: 20px; padding-bottom: 40px;"
    />
</a>

* Windows Subsystem for Linux
<a href="https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux" target="_blank">
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Tux.svg/64px-Tux.svg.png"
     width="80px;" style="display: block; margin-left: 50px; padding-top: 20px; padding-bottom: 40px;"
    />
</a>

* C++11
<a href="https://en.wikipedia.org/wiki/C%2B%2B14" target="_blank">
    <img src="https://cdn-icons-png.flaticon.com/512/6132/6132222.png"
         width="100px;" style="display: block; margin-left: 50px; padding-top: 20px; padding-bottom: 40px;"
    />
</a>

* Doxygen
<a href="https://www.doxygen.nl/" target="_blank">
    <img src="https://www.doxygen.nl/images/doxygen.png"
     width="200px;" style="display: block; margin-left: 50px; padding-top: 20px; padding-bottom: 40px;"
    />
</a>

* gcc/g++ GNU Compiler
<a href="https://gcc.gnu.org/" target="_blank">
    <img src="https://gcc.gnu.org/img/gccegg-65.png"
     width="100px;" style="display: block; margin-left: 50px; padding-top: 20px; padding-bottom: 40px;"
    />
</a>

* MinGW32/64
<a href="https://www.mingw-w64.org/" target="_blank">
    <img src="https://www.mingw-w64.org/header.svg#gh-light-mode-only"
     width="250px;" style="display: block; margin-left: 50px; padding-top: 20px; padding-bottom: 40px;"
    />
</a>

* git
<a href="https://git-scm.com/" target="_blank">
    <img src="https://git-scm.com/images/logo@2x.png"
     width="150px;" style="display: block; margin-left: 50px; padding-top: 20px; padding-bottom: 40px;"
    />
</a>

* xeus-cling
<a href="https://github.com/jupyter-xeus/xeus-cling" target="_blank">
    <img src="https://github.com/jupyter-xeus/xeus-cling/raw/main/docs/source/xeus-cling.svg"
     width="200px;" style="display: block; margin-left: 50px; padding-top: 20px; padding-bottom: 40px;"
    />
</a>

* GNU make (installed alongside g++/gcc compiler)
<a href="https://www.gnu.org/software/make/manual/make.html" target="_blank">
\htmlonly
    <script src="..\cstmz\js\toggle.js"></script>
    <div id="container">
		<img
			id="makelogo"
			src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Official_gnu.svg/563px-Official_gnu.svg.png?20080303012513"
			width="150px;" style="display: block; margin-left: 50px; padding-top: 20px; padding-bottom: 40px;"
		/>
    </div>
\endhtmlonly
</a>

endef
export TECH_HTML

# define future/purpose ...
define PURPOSE_HTML
@page Purpose Purpose

The project is an initiative to automate
<a href="https://en.wikipedia.org/wiki/Computing" target="_blank">
    programming & computing
</a> & a step towards simplifying the 
<a href="https://en.wikipedia.org/wiki/Software_documentation">
    software documentation process
</a> &
<a href="https://en.wikipedia.org/wiki/Compiler">
	the software compilation process
</a>

* @subpage modal "Modal Graphs"
* @subpage automata "Proof Automata"
endef
export PURPOSE_HTML

define SPECS_HTML
@page Specs Specs

This page accentuates the minimum hardware specifications and software requirements:

<h3><a href="https://en.wikipedia.org/wiki/Computer_hardware"> Hardware </a></h3>

<h3><a href="https://en.wikipedia.org/wiki/Software"> Software </a></h3>

See @ref Technologies "Technologies"
endef
export SPECS_HTML

# define tutorials.md page
define TUTORIAL_HTML
@page Tutorials Tutorials

- @subpage codeblocks "Code Blocks"
- @subpage latex "LaTeX Page"
- @subpage table "Table Page"

endef
export TUTORIAL_HTML

# define latex.md page
define LATEX_HTML
@page latex LaTeX Page

The powerseries representation \f( e = \sum_{n=0}^{\infty} \frac{x^n}{n!} \f) is an inline expression.

While the Gamma function below is a displaystyle \f(\LaTeX \f) expression ...
\f[
    \Gamma(z) = \int_{0}^{\infty} e^{-t} t^{z} dt
\f]

Furthermore, we can write & align equations like so ...
    
\f{eqnarray*}{
    x &= y + z\\
    r &= s + t\\
\f}
endef
export LATEX_HTML

# change this to something more generic ...
define MODAL_HTML
@page modal Modal Graphs

@defgroup ModalGraphs Modal Graphs

The Modal Logic utilities
are built on the
<a href="https://en.wikipedia.org/wiki/Graph_(abstract_data_type)" target="_blank">
    Graph Data Structure
</a>
with the intended purpose of exploring
<a href="https://en.wikipedia.org/wiki/Modal_logic" target="_blank">
    Modal Logic
</a>
endef
export MODAL_HTML

# define code blocks page to demonstrate how to define code blocks ...
define CODEBLOCKS_HTML
@page codeblocks Code Blocks

> Here is an example of a python (.py) script codeblock to detail the `dummy_function()`

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{.py}
# Dummy Class
class Dummy:
    def dummy_function():
        pass
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> Here is an example of a C++/C (.cpp/c) script codeblock to detail the `alt_function()`

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{.cpp}
// Alt Class
class Alt
{
public:
    void alt_function()
    {
        return;
    }
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
endef
export CODEBLOCKS_HTML

# demonstrate how to define tables in doxygen documentation ...
define TABLE_HTML
@page table Table Page

This page demonstrates the use of markdown tables in doxygen

| Left-Align   | Centered          | Right-Aligned   |
| :----------- | :---------------: | --------------: |
| Row 1, Col 1 | Row 1, Col 2      | Row 1, Col 3    |
| Row 2, Col 1 | Row 2, Col 2      | Row 2, Col 3    |
endef
export TABLE_HTML

# change this to something more generic ...
define AUTOMATA_HTML
@page automata Proof Automata

@defgroup ProofAutomata Proof Automata

The Proof Automata utilities
are built on the 
<a href="https://en.wikipedia.org/wiki/Tree_(data_structure)" target="_blank">
    Tree Data Structure
</a>
with the intended purpose of exploring
<a href="https://en.wikipedia.org/wiki/Method_of_analytic_tableaux" target="_blank">
    Analytic Tableaux
</a>
endef
export AUTOMATA_HTML

# release notes redirects to changelog & lisence agreement etc ...
define RELEASE_NOTES_HTML
# Release Notes {#releasenotes}

Any changes made to legal matters are expressed here:

First Release Date: <b>@showdate "%A %d-%m-%Y %H:%M"</b>

@copyright <br/> [copyright & lisence agreement](legal/lisence.md)

For any changes made to the software since the last release see @ref changelog "Change Log"

<a href="$(WEBSITE_URL)">$(COMPANY_NAME)</a>
endef
export RELEASE_NOTES_HTML

# This defines the main page for grouping all the log files in order ...
define CHANGELOG_HTML
@page changelog ChangeLog

This file keeps a record of all changes made
to the software since release, according to log numbers,
each written with the following standard date-time format:

    YYYY-MM-DD H:M:S Surname Name <developer@example.com>

        Fixed
            * bug in <some_source_code_file.cpp>
            
        Added
            * somefunction() in <some_source_code_file.cpp>
            
        Changed
            * <some_class.h> to <some_templated_class_class.h>
        
For any changes made to legal matters, see [Release Notes](legal/releasenotes.md) <br/>
        
<a href="$(WEBSITE_URL)">$(COMPANY_NAME)</a>

<br/>

<h3><b>ChangeLog</b></h3>
<br>

endef
export CHANGELOG_HTML

# Doxygen generates a directory tree for the `html` pages from the directory in which you run doxygen.
# Thus if you run doxygen from your local drive `C:\\` then the directory tree-view for the `html` pages,
# will contain all the folders, up to the project folder for which you actually want to generate the documentation.
# This is probably not desirable in most cases.
# Taken directly form the doxygen manual:
# ***"If the same tag is assigned more than once, the last assignment overwrites any earlier assignment"***

# We'll come back to this (LaTeX stuff ... ):
# Buidling .pdf from [$\LaTeX$](https://www.latex-project.org/) output using the generated Makefile
# It is necessary to install [MikTeX](https://miktex.org/)
# Additionally, it is generally a good idea to also have
# [Texmaker](https://www.xm1math.net/texmaker/download.html) installed but this is not required
# If this is your first time running the `makefile` produced by doxygen
# to compile the $\LaTeX$ output, it will prompt you to install some packages.
# See the attached screenshot/image
# On a windows machine, the indentation of a `makefile` can sometimes be problematic
# Removing the Watermark "Generated by Doxygen" from the $\LaTeX$ .pdf output
# https://stackoverflow.com/questions/16211207/remove-generated-by-doxygen-and-timestamp-in-pdf
# Produce the default `header.tex` file ...


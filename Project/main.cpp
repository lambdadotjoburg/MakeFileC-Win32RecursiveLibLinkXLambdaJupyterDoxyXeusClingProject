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


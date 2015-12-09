/*!
	\file "Main.cpp"
	Copyright (c) 2012 Bootstrap
	Formatting: 4 spaces/tab, 120 columns.
	Docs by Doxygen (http://www.doxygen.com/)
*/


#include "Sys/BootstrapDefs.hpp"


int main()
{
	ASSERT_MSG(1==0, "Hello, Bootstrap!");
	ASSERT(1==0);
	std::cerr << "Goodbye, Bootstrap!" << std::endl;
}

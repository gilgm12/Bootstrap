/*!
	\file "BootstrapDefs.hpp"

	Copyright (c) 2012 Bootstrap
	Formatting: 4 spaces/tab, 120 columns.
	Doc-tool: Doxygen (http://www.doxygen.com/)
*/


#ifndef INCLUDE_CC989188_6D99_4D9B_A13B_A21FB1E8834B
#define INCLUDE_CC989188_6D99_4D9B_A13B_A21FB1E8834B


#pragma once


#include "Sys/Error/BootstrapAssert.hpp"
#include <iostream>
#include <iomanip>
#include <memory>
#include <typeinfo>
#include <cmath>
#include <limits>
#include <sstream>
#include <vector>
#include <deque>
#include <list>
#include <map>
#include <algorithm>
#include <utility>
#include <string>
#include <limits.h>
#include <stdarg.h> // Variable argumetn lists.
#include <stdio.h> // stdin, stdout, stderr, ...


#define pblc public:
#define priv private:
#define ptcd protected:
#define UNREFERENCED(x) ((void)x)
#define null NULL
#define FORCE_DBG_STOP() asm("int $3")


#ifdef DEBUG
	#define ENABLE_ASSERTIONS
#endif

#ifdef ENABLE_ASSERTIONS
	#define ASSERT(condition) { \
		if (!condition) { \
			Bootstrap::Sys::CAssert(__FILE__,__FUNCTION__,__LINE__,#condition,null); \
			FORCE_DBG_STOP(); \
		} \
	}

	#define ASSERT_MSG(condition, message) { \
		if (!condition) { \
			std::ostringstream xOut; \
			xOut << message; \
			Bootstrap::Sys::CAssert(__FILE__,__FUNCTION__,__LINE__,#condition,xOut.str().c_str()); \
			FORCE_DBG_STOP(); \
		} \
	}
#else
	#define ASSERT(condition) {}
	#define ASSERT_MSG(condition, message) {}
#endif


#endif

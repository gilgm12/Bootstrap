/*!
	\file "BootstrapAssert.hpp"

	Copyright (c) 2012 Bootstrap
	Formatting: 4 spaces/tab, 120 columns.
	Doc-tool: Doxygen (http://www.doxygen.com/)
*/


#ifndef INCLUDE_CB0874F3_12C6_48FE_B268_4ED35F83C53F
#define INCLUDE_CB0874F3_12C6_48FE_B268_4ED35F83C53F


#pragma once


namespace Bootstrap {
namespace Sys {


class CAssert
{

	//!\name Trace
	//@{
	private: void PrintFooter();
	private: void PrintDivider();
	//@}

	//!\name Builder
	//@{
	private: void BuildAssertion(const char *acsFile, const char *acsFunc, int aiLine,
							 const char *acsCondition, const char *acsMessage);
	//@}


	//!\name Construct/Destruct
	//@{
	public: CAssert(const char * acsFile, const char * acsFunc, int aiLine, const char * acsCondition);
	public: CAssert(const char * acsFile, const char * acsFunc, int aiLine,
					const char * acsCondition, const char * acsMessage);
	virtual ~CAssert();
	//@}
};


} // namespace Sys {
} // namespace Bootstrap


#endif

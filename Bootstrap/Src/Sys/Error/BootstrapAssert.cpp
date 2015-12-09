/*!
	\file "BootstrapAssert.cpp"

	Copyright (c) 2012 Bootstrap
	Formatting: 4 spaces/tab, 120 columns.
	Doc-tool: Doxygen (http://www.doxygen.com/)
*/


#include "Sys/BootstrapDefs.hpp"


namespace Bootstrap {
namespace Sys {


void
CAssert::PrintDivider()
{
	std::cerr << "--------------------------------------" << std::endl;
}


void
CAssert::PrintFooter()
{
	PrintDivider();
}


void
CAssert::BuildAssertion(const char *acsFile, const char *acsFunc, int aiLine,
						const char *acsCondition, const char *acsMessage)
{
	PrintDivider();
	std::cerr << "RUNTIME ASSERTION" << std::endl;
	PrintDivider();
	std::cerr << "File:      " << acsFile << std::endl;
	std::cerr << "Method:    " << acsFunc << std::endl;
	std::cerr << "Line:      " << aiLine << std::endl;
	std::cerr << "Condition: " << acsCondition << std::endl;

	if (acsMessage != null)
	{
		std::cerr << "Message:   " << acsMessage << std::endl;
	}
}


//---------------------------------------=<( 120 Columns )>=-----------------------------------------------------------


CAssert::CAssert(const char *acsFile, const char *acsFunc, int aiLine, const char *acsCondition)
{
	BuildAssertion(acsFile, acsFunc, aiLine, acsCondition, null);
}


CAssert::CAssert(const char *acsFile, const char *acsFunc, int aiLine,
				 const char *acsCondition, const char *acsMessage)
{
	BuildAssertion(acsFile, acsFunc, aiLine, acsCondition, acsMessage);
}


CAssert::~CAssert()
{
	// Do nothing.
}


} // namespace Sys {
} // namespace Bootstrap {

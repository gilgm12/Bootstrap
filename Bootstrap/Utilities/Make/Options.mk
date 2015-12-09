#
#	\file "Options.mk"
#	Copyright (c) XXXX Bootstrap
#	Formatting: 4 spaces/tab, 120 columns.
#	Doc-tool: Doxygen (http://www.doxygen.com/)
#
# ---------------------------------------------------------------------------------------------------------------------
# Include this module in a makefile.
# ---------------------------------------------------------------------------------------------------------------------
.PHONY: ShowUsage
ShowUsage:
	@echo
	@echo "Bootstrap Makefile"
	@echo
	@echo "Usage:"
	@echo
	@echo "  Type=(Debug|Production), Debug or production build."
	@echo "  Profile=(true|false), Enable profile options."
	@echo

# Start 'option-free'
HaveOptions=false

# Check each option
ifneq ($(Type),)
	HaveOptions=true
endif
ifneq ($(Profile),)
	HaveOptions=true
endif

# Set default options here:
Type?=Debug
Profile?=false


# Be sure we specified a valid debug/production build type!
OptionsValid=true
ifeq ($(Type),Debug)
else
ifeq ($(Type),Production)
else
$(warning Type must be Debug or Production.)
OptionsValid=false
endif
endif


# Error out if our options are invalid.
ifeq ($(OptionsValid),false)
$(error Invalid options.  Run 'make' for usage.)
endif


# Sanity checks...
ifeq ($(.DEFAULT_GOAL),ShowUsage)
ifeq ($(HaveOptions),true)
ifeq ($(OptionsValid),true)
# when we get here, all is well.  set our target and roll.
.DEFAULT_GOAL:=all
endif
endif
endif

# ---------------------------------------------------------------------------------------------------------------------
# Bootstrap options END



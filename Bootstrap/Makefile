#
#	\file "Makefile"
#	Copyright (c) 2011 Bootstrap
#	Formatting: 4 spaces/tab, 120 columns.
#	Doc-tool: Doxygen (http://www.doxygen.com/)
#
# ---------------------------------------------------------------------------------------------------------------------
.SUFFIXES:
.SUFFIXES: .d
%.h: ;
%.hpp: ;
%.inl: ;

# Options module contains usage information.
include Utilities/Make/Options.mk

# Build Root
BuildRoot:=Builds
BinRoot:=$(BuildRoot)/Bin
ObjRoot:=$(BuildRoot)/Intermediate/$(Type)$(Target)

# Specify sets of build params.
CompFlags_Warnings:=-Wno-write-strings -Wno-attributes -pedantic -Wall -Wcast-qual -Wconversion \
	-Wextra -Winit-self -Wshadow -Wstrict-aliasing


# Compilation flags for _all_ targets.
CompFlags_Common:= -pipe

# Compilation flags for _debug_ targets.
CompFlags_Debug=-DDEBUG -g -ggdb

# Compilation flags for _production_ targets.
CompFlags_Production:=-DPRODUCTION -DNDEBUG -O3 -fgcse-sm -fgcse-las -fgcse-after-reload \
		-fgcse-after-reload -funsafe-loop-optimizations -fomit-frame-pointer

# Compilation flags added when profiling targets.
CompFlags_Profile:=-pg

# Link flags for _all_ targets.
LinkFlags_Common:=

# Link flags for _debug_ targets.
LinkFlags_Debug:=

# Link flags for _production_ targets.
LinkFlags_Production:=

# Link flags for targets being profiled.
LinkFlags_Profile:=-lefence


# Command Assembly
# --------------------------------------------------------------

# Common flags
BuildSuffix:=
CompFlags:=$(CompFlags_Warnings) $(CompFlags_Common)
LinkFlags:=$(LinkFlags_Common)

# Profile flags
ifeq ($(Profile),true)
CompFlags_Debug+=$(CompFlags_Profile)
LinkFlags_Debug+=$(LinkFlags_Profile)
endif

# Production/Debug flags
ifeq ($(Type),Debug)
CompFlags+=$(CompFlags_Debug)
LinkFlags+=$(LinkFlags_Debug)
BuildSuffix:=$(BuildSuffix)Dbg
else
CompFlags+=$(CompFlags_Production)
LinkFlags+=$(LinkFlags_Production)
endif

# Bootstrap Target(s)
Target_Bootstrap:=$(BinRoot)/Bootstrap$(BuildSuffix)

# Main specification of target(s)
Targets=$(Target_Bootstrap)
Targets_Clean:=$(Targets) $(ObjRoot)

# Set up library depenencies.
$(Target_Bootstrap): Libs:=
$(Target_Bootstrap): LibDirs:=

# Load list of files to build.
include Bootstrap.modules

# Specify Objects
Bootstrap_Objs:=$(subst Src,$(ObjRoot),$(Files:%=%.o))
Objs:=$(Bootstrap_Objs)

$(Target_Bootstrap): Target_Objs:=$(Bootstrap_Objs)

# Calc dep filenames and list of output dirs to create.
Deps_Bootstrap:=$(Bootstrap_Objs:%.o=%.d)
Deps=$(Deps_Bootstrap)

# Determing intermediate object dirs. (staging)
Dirs:=$(sort $(BinRoot)/ $(ObjRoot)/ $(dir $(Objs))) Builds/Intermediate

# Include
Includes:=$(shell cat 'Bootstrap.includes')
Includes:=$(foreach Include,$(Includes),-I$(Include))

# ---------------------------------------------------------------------------------------------------------------------
# Targets
# ---------------------------------------------------------------------------------------------------------------------


.PHONY: all
all: $(Targets)

.PHONY: all_targets
all_targets:
		$(MAKE) clean_all Type=Debug      Profile=false
		$(MAKE) clean_all Type=Production Profile=false
		$(MAKE) clean_all Type=Debug      Profile=true
		$(MAKE) clean_all Type=Production Profile=true

.PHONY: clean
clean:
	rm -rf $(Targets_Clean) &> /dev/null

.PHONY: clean_all
clean_all:
	rm -rf $(BuildRoot) &> /dev/null

.PHONY: print-%
print-%:
	@echo '$($*)'

# Create staging dirs.
$(Dirs): $(Makefiles)
	mkdir -p "$@" &> /dev/null

# Rule for adding our local option defs from a template if they don't already exist.
Src/BootstrapLocalOpts.hpp: Src/BootstrapLocalOpts.hpp.tmpl
	echo "Generating $@."
		if ! [ -e Src/BootstrapLocalOpts.hpp ] ; then cp Src/BootstrapLocalOpts.hpp.tmpl Src/BootstrapLocalOpts.hpp ; fi ; \
				touch -r Src/BootstrapLocalOpts.hpp.tmpl Src/BootstrapLocalOpts.hpp

# Rules for _all_ project objects.
$(Objs): $(Makefiles) Src/BootstrapLocalOpts.hpp | $(Dirs)
	echo "Bootstrap compiling $(subst $(ObjRoot)/,,$(@:%.o=%))."
		g++ -c $(CompFlags) $(Includes) -MMD -MT $@ -MF $(@:%.o=%.d) -o $@ $(subst $(ObjRoot),Src,$(@:%.o=%))

# Make the bootstrap target dependent on its own objects.
$(Target_Bootstrap): $(Bootstrap_Objs)

# Rule for _all_ targets.
$(Targets): $(Makefiles)| $(Dirs)
	echo "Linking $@."
		g++ $(CompFlags) $(Includes) $(LinkFlags) $(LibDirs) $(Libs) -o $@ $(Target_Objs) \
		-Wl,-Map=$@.map

.PHONY: docs
docs:
		@doxygen Bootstrap.doxygen.cfg 2>&1 | sed 's|$(PWD)/||g'

# Update and include dependency information.
ifneq ($(MAKECMDGOALS),clean)
-include $(Deps)
endif

# Bootstrap Makefile END

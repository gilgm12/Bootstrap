#! /bin/bash

# To prevent commit cycling on file lists, force the sort order to match c.
export LC_COLLATE=C

# Find the absolute root dir.
Base="$(readlink -m "${BASH_SOURCE[0]}/../../..")"

# Add source files to project.
find "$Base/Src" -regextype posix-extended -type f \
	\( -regex '.*\.(c|cpp|h|hpp|inl|mk)$' -or -iname '[Mm]akefile' \) | \
	sed "s|$Base/||g" | grep -v -e '^\..*' -e '.*/\.' > "$Base/Bootstrap.files"

# Add root files to project.
echo -e "Makefile\nBootstrap.modules\nBootstrap.creator\nBootstrap.creator.user.tmpl\nBootstrap.doxygen.cfg\nSrc/BootstrapLocalOpts.hpp.tmpl\n" \
	>> "$Base/Bootstrap.files"

# Add utilities to project.
find "$Base/Utilities" -type f | sed "s|$Base/||g" | grep -v -e '^\..*' -e '.*/\.' >> "$Base/Bootstrap.files"

# Update modules include.
{
	echo "Files:= \\"
	grep -E '.*\.(c|cpp)$' < "$Base/Bootstrap.files" | sort | sed 's|\(.*\)|\t\1 \\|'
	echo
} > "$Base/Bootstrap.modules"

# Sort
sort -o "$Base/Bootstrap.files" "$Base/Bootstrap.files"

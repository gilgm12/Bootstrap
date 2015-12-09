#!/bin/sh

WriteHeader()
{
	local File=$1;
	echo "/*!"
	echo -e "	\\\file \"$File\""
	echo -e "	Copyright (c) $(date +%Y) Bootstrap"
	echo -e "	Formatting: 4 spaces/tab, 120 columns."
	echo -e "	Docs by Doxygen (http://www.doxygen.com/)"
	echo "*/"
	Separator
}

Separator()
{
	echo
	echo
}

Uuid()
{
	eight=$(printf "%s" "$(dd if=/dev/urandom bs=4 count=1 2>/dev/null)" | od -t x1 -An | tr -dc '[:alnum:]')
	four1=$(printf "%s" "$(dd if=/dev/urandom bs=2 count=1 2>/dev/null)" | od -t x1 -An | tr -dc '[:alnum:]')
	four2=$(printf "%s" "$(dd if=/dev/urandom bs=2 count=1 2>/dev/null)" | od -t x1 -An | tr -dc '[:alnum:]')
	four3=$(printf "%s" "$(dd if=/dev/urandom bs=2 count=1 2>/dev/null)" | od -t x1 -An | tr -dc '[:alnum:]')
	twelve=$(printf "%s" "$(dd if=/dev/urandom bs=6 count=1 2>/dev/null)" | od -t x1 -An | tr -dc '[:alnum:]')
	id=$(printf "%s_%s_%s_%s_%s" $eight $four1 $four2 $four3 $twelve)
	echo $id | tr '[a-z]' '[A-Z]';
}

WriteGuard()
{
	local Id=$(Uuid);
	local Guard=$(awk '{print toupper($0)}' <<< "Bootstrap_$Id");
	echo "#ifndef $Guard";
	echo "#define $Guard";
	Separator;
	echo "#pragma once";
	Separator;
}

WriteFooter()
{
	echo "#endif";
}

Path=$(readlink -m "$1");
Dir=${Path%/*}
File=${Path##*/}
Base=${File%.*}
Ext=${File##*.}
Header=$Base."hpp";

# Write our source module
{
	WriteHeader $File
} > "$Dir/$File";

# Write our header module
{
	WriteHeader $Header
	WriteGuard
	WriteFooter
} > "$Dir/$Header";

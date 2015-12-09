#!/bin/sh

# Find the path of the target, and template.
Base="$(readlink -m "${BASH_SOURCE[0]}/../../..")"
Dest="$Base/Bootstrap.creator.user"
Tmpl="$Dest.tmpl"

if [ -e $Dest ]; then
	echo "$Dest exists!  Manually delete it if you would like this script to regenerate it.";
	exit 1;
fi

cp $Tmpl $Dest;



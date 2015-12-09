#!/bin/sh

APPNAME=${1?"Please specify an application name and try again."};

# Fetch Bootstrap Files.
cd Bootstrap;

BootstrapFiles=$(find . -not -path '*/\.*' -type f)

for file in $BootstrapFiles;
do
	echo "Processing " + $file;

	# Convert line endings
	sed -i '' -e 's/\r\+$//' $file;

	# Replace file contents
	sed -i '' -e "s/Bootstrap/$APPNAME/g" $file;

	# Fetch updated filename.
	newfile=$(echo $file | sed s/Bootstrap/$APPNAME/g)

	# Rename the file, if necessary.
	test "$file" != "$newfile" && mv "$file" $newfile
done

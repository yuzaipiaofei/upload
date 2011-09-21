#! /bin/bash
#
# gen_bash_script - generate bash script via a templete
#
# usage: gen_bash_script NAME

PROGRAM=$(basename "$0")

[[ $1 == --* ]] && {
	echo "$PROGRAM: $PROGRAM NAME"
	exit 0
}

if echo $1 | grep -v -E '^[a-zA-Z][a-zA-Z0-9_]*$' &> /dev/null; then
	echo "$PROGRAM: Unavailable name!"
	exit 1
fi

[[ -e $1.sh ]] && { echo "$PROGRAM: File exists!"; exit 2; }
if ! touch $1.sh &> /dev/null; then
	echo "$PROGRAM: Cannot create $1.sh"
	exit 2
fi

# Generate script
cat << EOF > $1.sh
#! /bin/bash
#
# Automatically generated by gen_bash_script.sh
#
# TODO

# usage: $1 # TODO
$1() {

	# Debug switcher & local TAG
	# example: \$DBG && echo \$TAG:...
	local DBG=true
	local TAG=\${TAG:-\${FUNCNAME[0]}}

	[[ \$1 == --* ]] && {
		echo "\$PRO: \$PRO" # TODO
		return 0
	}
	
	# TODO

	return \$?
}

# Script can be used as a program or a function
if echo \$0 | grep -v -E '^[-]?bash' &> /dev/null; then

	# Global VARs
	PRO=\$(basename "\$0")
	TAG=\$PRO

	# Main
	$1 "\$@"
fi
EOF

echo "$PROGRAM: Generate $1.sh done."
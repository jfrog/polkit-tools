#!/bin/bash

PKEXEC=$(which pkexec)

# Test that detector was built
if [ ! -f "pwnkit_detector" ]; then
	echo 'ERROR: "pwnkit_detector" executable missing. Please run "make"'
	exit
fi

# Test that pkexec exists
if [ ! -f "${PKEXEC}" ]; then
	echo 'NOT VULNERABLE - "pkexec" does not exist'
	exit
fi

# Test for pkexec SUID
if [ ! -u "${PKEXEC}" ]; then
	echo 'NOT VULNERABLE - "pkexec" is not setuid'
	exit
fi

# Test a "dry run" of the exploit
# A vulnerable "pkexec" will try to run the nonexistent "fake_run" binary due to the exploit
# and subsequently print that "fake_run" was not found. Patched version will just bail.
./pwnkit_detector "${PKEXEC}" 2>&1 | grep -q fake_run
if [ $? -ne 0 ]; then
	echo 'NOT VULNERABLE - "pkexec" is patched'
	exit
fi

echo "VULNERABLE"

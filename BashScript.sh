#! /bin/bash
#
# .SYNOPSIS
#  Script that validate password strength
#
# .DESCRIPTION
#  Script that  validate password strength by the following requitements:
#  Length – minimum of 10 characters.
#  Contain both alphabet and number.
#  Include both the small and capital case letters.
#  Color the output (as seen in expected result) green if it passed the validation and red if it didn’t.
# Return exit code 0 if it passed the validation and exit code 1 if it didn’t.

# EXAMPLE USAGE
# ./password-validator.sh "MyP@ssw0rd!"


GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
WEAK='Weak Password Should include'


if [ ${#1} -lt 10 ]
then
   	echo "${RED} ${WEAK} 10 chars!!!"
elif [[ ${1} =~ ^[A-Za-z_]+$ ]]
then
	echo "${RED} ${WEAK} numbers"
elif [[ $1 =~ ^[0-9]+$ ]]
then
	echo "${RED} ${WEAK} alphabet"
elif [[ ${1} =~ ^[^A-Z]+$ ]]
then
	echo "${RED} ${WEAK} Upper case"
elif [[ ${1} =~ ^[^a-z]+$ ]]
then
	echo "${RED} ${WEAK} Lower case"
else
	echo "${GREEN}This is an awesome password!"
fi



#!/bin/bash

# export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
# set -x

###########################################
# position parameters OR passed arguments #
###########################################
printf "\n--- arguments OR position parameter ---\n"
echo "absolute path to shell or script: $0"
echo "first argument: $1"
echo "number of arguments: $#"
echo "all passed arguments with @: $@"
echo "all passed arguments with *: $*"
echo "Display current bash version: ${BASH_VERSION}"
echo "1234"
echo "Most recent parameter (or the abs path of the command to start the current shell immediately after startup): $_"

#########
# truth #
#########
printf "\n--- truth ---\n"

matchOne=1
if ((matchOne)); then
  echo "1 and above matches true"
else
  echo "1 and above matches true NOT"
fi

matchAboveOne=2
if ((matchAboveOne)); then
  echo "1 and above matches true"
else
  echo "1 and above matches true NOT"
fi

matchZero=0
if ((matchZero)); then
  echo "0 matches false NOT"
else
  echo "0 matches false"
fi

########################
# Simple string concat #
########################
printf "\n--- string concat ---\n"

# values to work with
A=Hello
B=world
C="!"

#
res1="res1: ${A} ${B} ${C}"
res2='res2: '${A}' '${B}' '${C}
echo ${res1}
echo ${res2}

##############
# arithmetic #
##############
printf "\n--- arithmetic ---\n"

declare -i number1=1
declare -i number2=2
number3=3

number12=$((${number1}+${number2}))
echo "Arithmetic: number1 + number2 = ${number12}"

##########
# arrays #
##########
printf "\n--- arrays ---\n"

# create empty array direct without 'declare'
EMPTY_ARRAY1=()

# create empty array direct
declare -a EMPTY_ARRAY2

# get number of elements
NUMBER_OF_ELEMENTS1=${#EMPTY_ARRAY1}
NUMBER_OF_ELEMENTS2=${#EMPTY_ARRAY2}

# print result
echo "Number of elements in empty array 1: ${NUMBER_OF_ELEMENTS1}"
echo "Number of elements in empty array 2: ${NUMBER_OF_ELEMENTS2}"

A1="A1"
A2="A2"
A3="A3"

# Access simple array
ASSIGNED_ARRAY1=(A1 A2 A3);
echo "Assigned array 1: ${ASSIGNED_ARRAY1[*]}"

# Array within array, call by reference
B1='B1'
ASSIGNED_ARRAY2=(ASSIGNED_ARRAY1 B1);
echo "Assigned array 2: ${ASSIGNED_ARRAY2[*]}"

# Change ASSIGNED_ARRAY1 to demonstrate call by reference
ASSIGNED_ARRAY1[1]='AA2'
echo "Change 'ASSIGNED_ARRAY1' cell[1] to demostrate call by reference: ${ASSIGNED_ARRAY1[1]}"

# Access array within array
# eval echo \${${ASSIGNED_ARRAY2[0]}[1]}

# Access array within array and store it in a variable
# A2_VALUE=$(eval echo \${${ASSIGNED_ARRAY2[0]}[1]})
A2_VALUE=$(eval echo "\${${ASSIGNED_ARRAY2[0]}[1]}")
echo "Access 'ASSIGNED_ARRAY1' cell[1] from 'ASSIGNED_ARRAY2' value is a call by reference: ${A2_VALUE}"

# Create an assoziative array
declare -A ASSOCIATIVE_ARRAY1
declare -A ASSOCIATIVE_ARRAY2=(
  ['a1']='value_a1'
  ['a2']='value_a2'
  ['a3']='value_a3'
)
echo "Value from 'ASSOCIATIVE_ARRAY2' cell['a2']: ${ASSOCIATIVE_ARRAY2['a2']}"
echo "Number of elements in 'ASSOCIATIVE_ARRAY2': ${#ASSOCIATIVE_ARRAY2[*]}"

# Unset an entire array
unset -v ASSOCIATIVE_ARRAY1

# Unset an element in an array
unset -v 'ASSOCIATIVE_ARRAY2[a2]'
echo "Number of elements in 'ASSOCIATIVE_ARRAY2': ${#ASSOCIATIVE_ARRAY2[*]}"

#############################################################
# test command                                              #
# source: http://wiki.bash-hackers.org/commands/classictest #
#############################################################
printf "\n--- test ---\n"

# test command - file exists
if [ -f /etc/passwd ]; then
  echo "'/etc/passwd' exists."
else
  echo "'/etc/passwd' NOT exists."
fi

# test a composed condition to check
var1='/etc/passwd'
var2=''
if [ -n "${var1}" ] && [ -f "${var1}" ] && [ -r "${var1}" ]; then
  echo "'var1' is not empty AND ${var1} is a regular file AND it is readable."
  if [ -n "${var2}" ]; then
    echo "'var2' is NOT empty."
  else
    echo "'var2' IS empty."
  fi
else
  echo "Something is wrong with 'var1'."
fi

# get the last return code from the 'test' command
[ -w "${var1}" ];
declare -i ret=$?;
echo "res: ${ret}"

# declare a variable but do not assign a value to it
declare var_null

# rerturn 'false' in case of 'null' passed to 'test'
if [ "${var_null}" ]; then
  echo "ret: TRUE"
else
  echo "ret: FALSE"
fi

# conditional statement with NEGATION
local destination_file=$1
if ! [ -n "${destination_file}" ]; then
  echo "File path '$destination_file' is invalid or file is NOT writeable."
  exit 1
fi


# if [ ${BLUPP} -eq 0 ] ; then echo "NULL" ; fi
# if [[ ${BLUPP} -eq 0 ]] ; then echo "NULL" ; fi
# if [[${BLUPP} -eq 0]] ; then echo "NULL" ; fi
# declare BLUPP
# if [[ ${BLUPP} -eq 1 ]] ; then echo "NULL" ; fi

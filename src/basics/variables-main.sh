#!/bin/bash

A="A_value"
B="B_value"

# local shell values
printf "\n--- Display variables from 'main' ---\n"
echo "A: ${A}"
echo "B: ${B}"

# execute script
printf "\n--- Display variables BEFORE export ---\n"
./variables-A.sh

# export variables and execute script again
export A
export B
printf "\n--- Display variables AFTER export ---\n"
./variables-A.sh

# change a variable in a subshell/child-process
printf "\n--- Change value of 'B' in script 'variables-B.sh' ---\n"
./variables-B.sh

printf "\n--- Display variables from 'main' ---\n"
echo "A: ${A}"
echo "B: ${B}"

# export variable in a subshell/child-process
printf "\n--- Display variables introduced in 'variables-C.sh' ---\n"
./variables-C.sh
echo "C: ${C}"
echo "D: ${D}"

# 'source' the script to export variable from a subshell/child-process
printf "\n--- Display variables introduced in 'variables-C.sh' with 'source' ---\n"
source ./variables-C.sh
echo "B: ${B}"
echo "C: ${C}"
echo "D: ${D}"

printf "\n--- Display variables overwritten in 'variables-C.sh' with 'source' and called from 'variables-B.sh' ---\n"
source ./variables-B.sh

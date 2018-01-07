#!/bin/bash

number_positional_parameters=$#
positional_parameter_0=$0
positional_parameter_1=$1
positional_parameter_2=$2
positional_parameter_3=$3
global_string="global_string"

printf "\n--- executing commands from shell with level: ${SHLVL} ---\n"
echo "Number of positional parameters passed to this script: ${number_positional_parameters}"
echo "Positional parameter 0: ${positional_parameter_0}"
echo "Positional parameter 1: ${positional_parameter_1}"
echo "Positional parameter 2: ${positional_parameter_2}"
echo "Positional parameter 3: ${positional_parameter_3}"
echo "Test global string: ${global_string}"

# define arguments
arg_0="hello"
arg_1="world"
arg_2=1234

# run a script in a subshell with '3' arguments
./function-arguments-A.sh $arg_0 $arg_1 $arg_2

# define a function
func_0() {
  printf "\n--- executing 'func_0' from shell with level: ${SHLVL} ---\n"
  local number_positional_parameters=$#
  local positional_parameter_0=$0
  local positional_parameter_1=$1
  local positional_parameter_2=$2
  local positional_parameter_3=$3
  local global_string="local_string"
  echo "Number of positional parameters passed to this script: ${number_positional_parameters}"
  echo "Positional parameter 0: ${positional_parameter_0}"
  echo "Positional parameter 1: ${positional_parameter_1}"
  echo "Positional parameter 2: ${positional_parameter_2}"
  echo "Positional parameter 3: ${positional_parameter_3}"
  echo "Test global string: ${global_string}"
}

# run a function with '3' arguments
func_0 $arg_0 $arg_1 $arg_2

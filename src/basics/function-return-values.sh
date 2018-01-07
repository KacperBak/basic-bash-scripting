#!/bin/bash

# return a numeric status code via 'return' command
function_with_numeric_return_value() {
    printf "\n--- executing function 'function_with_numeric_return_value' from shell with id: ${BASHPID} ---\n"
    local ret_val=0
    return $ret_val
}

# return a string value via 'stdout' file descriptor
function_with_string_return_value() {
  printf "\n--- executing function 'function_with_string_return_value' from shell with id: ${BASHPID} ---\n"
  local ret_val="return-a-string"
  echo $ret_val
}

# Display a numeric return value
printf "\n--- Display a numeric return value ---\n"
function_with_numeric_return_value
numeric_value=$?
echo "last return: ${numeric_value}"

# Display a string value via stdout file descriptor
printf "\n--- Display a string return value ---\n"
# Execute the function in a subshell and use the stdout file descriptor as a return value
string_value=$(function_with_string_return_value)
echo "last return: ${string_value}"

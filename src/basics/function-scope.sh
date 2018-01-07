#!/bin/bash

# declare global variable
global_var0="global_var0_value"

# declare global functions
func0() {
    # global variable defintion, but called from a subshell
    func0_var="func0_var_value"
    echo "func0_var: ${func0_var}"
}

func1() {
    # global variable defintion, called from the current shell
    func1_var="func1_var_value"
    echo "func1_var: ${func1_var}"
}

func2() {
    # local variable definition
    local func2_var="func2_var_value"
    echo "func2_var: ${func2_var}"
}

func3() {
    # local variable definition
    declare func3_var="func3_var_value"
    echo "func3_var: ${func3_var}"
}

echo "--- function calls ---"
# call function in a subshell: varibale scope remains in the sub shell
(func0)

# call functions
func1
func2
func3

echo "--- echo calls ---"
# print values
echo "global_var0: ${global_var0}"
echo "func0_var: ${func0_var}"
echo "func1_var: ${func1_var}"
echo "func2_var: ${func2_var}"
echo "func3_var: ${func3_var}"

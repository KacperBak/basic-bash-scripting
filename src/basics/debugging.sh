#!/bin/bash



# print the script source, the line number, the called/evaluated command
# source: http://stackoverflow.com/questions/951336/how-to-debug-a-bash-script
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
set -x

# commands to debug
# rerturn 'false' in case of 0 arguments passed to 'test'
if [  ]; then
  echo "ret: TRUE"
else
  echo "ret: FALSE"
fi

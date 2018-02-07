#!/bin/bash

date_formatted(){
  echo $(date +%Y-%m-%d_%H:%M:%S)
}

validate_exit_status_code() {
  local ret=$?
  if [[ "$ret" -ne 0 ]]; then
    echo "FATAL: Last exit code was NOT '0' !!!"
    exit 1
  fi
}

################################################################################
# LOGGER: DEFINE FUNCTIONS
################################################################################

logger_info() {
  local message="$1"
  local level="INFO"
  echo "${level} : ${message}"
}

logger_fatal() {
  local message="$1"
  local level="FATAL"
  echo "${level}: ${message}"
  echo "${level}: ${message}" >> "${SETUP_LOG_FILE_ABSOLUTE_PATH}"
  exit 1
}


################################################################################
# SNIPPETS DEPENDING FROM LOGGER
################################################################################
# Usage: set_global_variable "var_name" "var_value"
set_global_variable() {
  # check variable name and value
  if [[ "${#1}" -eq 0 ]]; then
    logger_fatal "Missing 'name' as positional parameter!"
  fi
  if [[ "${#2}" -eq 0 ]]; then
    logger_fatal "Missing 'value' as positional parameter!"
  fi

  # define and export
  readonly "$1"="$2"
  export "$1"
}

delete_file_or_folder(){
  local path_to_delete=$1
  if [[ "${#path_to_delete}" -eq 0 ]]; then
    logger_fatal "Missing 'path_to_delete' as positional parameter!"
  fi

  if [[ -f "$path_to_delete" ]] || [[ -d "$path_to_delete" ]]; then
    /bin/rm -rf "$path_to_delete"
    logger_info "Deleted: '${path_to_delete}'."
  fi
}

check_is_64_bit_architecture(){
  local arch=$(uname -m)
  if [[ "${#arch}" -eq 0 ]] || [[ "${arch}" != "x86_64" ]]; then
    echo "FATAL: Unsupported architecture detected: '${arch}' !!!"
    exit 1
  fi
}

to_lower_case(){
  echo "$1" | awk '{print tolower($0)}'
}

##############
# TEST DRIVE #
##############
execution_date=$("date_formatted")
echo "formatted date is: ${execution_date}"




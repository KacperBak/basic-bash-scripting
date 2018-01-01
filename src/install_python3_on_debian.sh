#!/bin/bash

################################################################################
# RUNTIME CHECK: EXECUTE
################################################################################

# Check execution as 'root' user
if [[ "$(id -u)" != "0" ]]; then
  echo "FATAL: Script does NOT run as 'root' user !!!"
  exit 1
fi

# Check is 'x64' architecture
arch=$(uname -m)
if [[ "${#arch}" -eq 0 ]] || [[ "${arch}" != "x86_64" ]]; then
  echo "FATAL: Unsupported architecture detected: '${arch}' !!!"
  exit 1
fi

# Install a Debian package
install_debian_package() {
  local package_name=$1
  local match_package_is_already_installed="ii-$package_name"

  local match_result
  match_result=$(dpkg --list | awk '{print $1"-"$2}' | grep -x "${match_package_is_already_installed}")

  # if 'match_result' is empty, try to install
  if [[ "${#match_result}" -eq 0 ]]; then
    echo "Package '${package_name}' is NOT installed. Try to install ..."

    # install package and confirm all prompts with 'yes', redirect 'stderr' and 'stdout' to '/dev/null'
    apt-get -y --quiet install "${package_name}" 2>&1 1>/dev/null

    local match_result_after_install
    match_result_after_install=$(dpkg --list | awk '{print $1"-"$2}' | grep -x "${match_package_is_already_installed}")

    # if 'match_result_after_install' is empty, abort with fatal
    if [[ "${#match_result_after_install}" -eq 0 ]]; then
      echo "Failed to install package ${package_name}."
      exit 1
    fi
  fi

  echo "Package '${package_name}' is ready to use."
}

################################################################################
# LOGGER : EXECUTE
################################################################################
logger_info "Setup working dir: '${SETUP_WORKING_DIR}'."


################################################################################
# UTILS: DEFINE FUNCTIONS
################################################################################

validate_exit_status_code() {
  local ret=$?
  if [[ "$ret" -ne 0 ]]; then
    echo "FATAL: Last exit code was NOT '0' !!!"
    exit 1
  fi
}

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

################################################################################
# UTILS: DEFINE FUNCTIONS
################################################################################

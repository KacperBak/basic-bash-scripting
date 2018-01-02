#!/bin/bash

################################################################################
# RUNTIME CHECK: EXECUTE
################################################################################

# Check execution as 'root' user
if [[ "$(id -u)" != "0" ]]; then
  echo "FATAL: Script does NOT run as 'root' user !!!"
  exit 1
fi

# TODO implement check if OS uses 'apt-get' as package manager

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
  exit 1
}

################################################################################
# UTILS: DEFINE FUNCTIONS
################################################################################

validate_exit_status_code() {
  local ret=$?
  if [[ "$ret" -ne 0 ]]; then
    echo "FATAL: Last exit code was NOT '0'."
    exit 1
  fi
}

################################################################################
# UPDATE PACKAGES: DEFINE FUNCTIONS
################################################################################
# Usage: update_package_dependencies "skip_updates"
update_package_dependencies() {
  apt-get -y --quiet update 3>&2 2>&1 1>/dev/null
  logger_info "Update packages finished."
}


################################################################################
# UPGRADE PACKAGES: DEFINE FUNCTIONS
################################################################################
# Usage upgrade_package_dependencies "skip_upgrades"
upgrade_package_dependencies() {
  apt-get -y --quiet upgrade 3>&2 2>&1 1>/dev/null
  logger_info "Upgrade packages finished."
}

################################################################################
# UPGRADE PACKAGES: EXECUTE
################################################################################

validate_exit_status_code;

################################################################################
# INSTALL DEBIAN PACKAGE: DEFINE FUNCTIONS
################################################################################
# Usage install_package "ssh"
install_package() {
  local package_name=$1
  local match_package_is_already_installed="ii-$package_name"

  local match_result
  match_result=$(dpkg --list | awk '{print $1"-"$2}' | grep -x "${match_package_is_already_installed}")

  # if 'match_result' is empty, try to install
  if [[ "${#match_result}" -eq 0 ]]; then
    logger_info "Package '${package_name}' is NOT installed. Try to install ..."

    # install package and confirm all prompts with 'yes', redirect 'stderr' and 'stdout' to '/dev/null'
    apt-get -y --quiet install "${package_name}" 2>&1 1>/dev/null

    local match_result_after_install
    match_result_after_install=$(dpkg --list | awk '{print $1"-"$2}' | grep -x "${match_package_is_already_installed}")

    # if 'match_result_after_install' is empty, abort with fatal
    if [[ "${#match_result_after_install}" -eq 0 ]]; then
      logger_fatal "Failed to install package ${package_name}."
    fi
  fi

  local success_message="Package '${package_name}' is ready to use."
  logger_info "${success_message}"
}


install_package_no_logger() {
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
# INSTALL DEBIAN PACKAGE: EXECUTE
################################################################################
update_package_dependencies
validate_exit_status_code;

#upgrade_package_dependencies
#validate_exit_status_code;

install_package "python3"
validate_exit_status_code;

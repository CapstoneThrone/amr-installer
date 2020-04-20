#!/bin/bash -x

# Check for password
if [[ -z $1 ]]; then
  echo "No ros-adm password supplied"
  echo "Please run with both the robot name and ros-adm password"
  echo '"./cleanup.sh <ros-adm password>"'
fi

VAULT_PASS="$2"

# Setup password for vault
export DEFAULT_VAULT_PASSWORD_FILE="/tmp/.ros-vault"
echo $VAULT_PASS > $DEFAULT_VAULT_PASSWORD_FILE


ansible-playbook -v 4-cleanup-default-user.yml
ansible-playbook -v 5-install-deps.yml

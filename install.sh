#!/bin/bash -x

# Check for name
if [[ -z $1 ]]; then
  echo "No hostname/robot name supplied"
  echo "Please run with both the robot name and ros-adm password"
  echo '"./install.sh <robot name> <ros-adm password>"'
fi

# Check for password
if [[ -z $2 ]]; then
  echo "No ros-adm password supplied"
  echo "Please run with both the robot name and ros-adm password"
  echo '"./install.sh <robot name> <ros-adm password>"'
fi

ROBOT_HOSTNAME="$1"
VAULT_PASS="$2"

# Setup password for vault
export DEFAULT_VAULT_PASSWORD_FILE="/tmp/.ros-vault"
echo $VAULT_PASS > $DEFAULT_VAULT_PASSWORD_FILE


ansible-playbook -v -e hostname=$ROBOT_HOSTNAME 1-setup-net.yml
ansible-playbook -v 2-setup-users.yml
ansible-playbook -v 3-configure.yml


set +x

for i in {1..5}; do
  echo "REBOOT AND LOG IN AS 'ros-adm' BEFORE RUNNING ./cleanup.sh"
done

#!/bin/bash

set -ex

echo "==================================================="
echo "Setup Start"
echo "==================================================="

USER=$(source ./scripts/check_user.sh)
OS=$(source ./scripts/check_os.sh)

if [[ $OS == "ubuntu" ]]; then
    source ./scripts/ubuntu/configure_settings.sh
    source ./scripts/ubuntu/install_applications.sh
elif [[ $OS == "rocky" ]]; then
    source ./scripts/rocky/configure_settings.sh
    source ./scripts/rocky/install_applications.sh
fi

echo "==================================================="
echo "Setup Success"
echo "System Reboot"
echo "==================================================="
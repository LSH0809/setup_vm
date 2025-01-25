#!/bin/bash

if [[ $(whoami) != "root" ]]; then
    echo "[ERROR] This script must be run as root"
    exit 1
else
    echo "root"
fi

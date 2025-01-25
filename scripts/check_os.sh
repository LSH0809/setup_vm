#!/bin/bash

OS=$(grep -w ID /etc/os-release | cut -d'=' -f2 | tr -d '"')

if [[ $? -ne 0 ]]; then
    echo "[ERROR] Failed to check OS"
    exit 1
fi

if [[ $OS == "ubuntu" || $OS == "rocky" ]]; then
    echo $OS
else
    echo "[ERROR] Unsupported OS: $OS"
    exit 1
fi

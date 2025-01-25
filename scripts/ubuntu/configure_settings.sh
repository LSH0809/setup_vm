#!/bin/bash

#===================================================
# Methods
function prepare_apt() {
    apt clean \
    && apt update \
    && apt upgrade -y \
    && apt autoremove --purge -y
}

function disable_swap() {
    swapoff -a
    sed -i "s/^\(.*swap.*\)/#\1/" /etc/fstab
}

function disable_snap() {

    wait_for_snap() {
        echo "Checking Progress for conflicting Snap operations..."
        while snap changes | grep -q "Doing"; do
            sleep 3
        done
    }

    remove_snap_packages() {
        local snap_packages=("firefox" "gnome-42-2204" "gtk-common-themes" \
                         "snapd-desktop-integration" "snap-store" "core22" "bare" "snapd")

        for package in "${snap_packages[@]}"; do
        if snap list | grep -q "$package"; then
            wait_for_snap
            snap remove --purge "$package"
        else
            echo "Snap package $package not found."
        fi
        done
    }

    systemctl disable snapd.service
    systemctl disable snapd.socket
    systemctl disable snapd.seeded.service

    remove_snap_packages

    systemctl stop snapd.service
    systemctl stop snapd.socket
    systemctl stop snapd.seeded.service

    rm -rf ~/snap
    rm -rf /var/cache/snapd
    rm -rf /var/snap
}

function set_ntp() {
    timedatectl set-timezone Asia/Seoul
    timedatectl set-ntp true

    systemctl restart systemd-timesyncd
}

function disable_system_flags() {
    systemctl disable systemd-networkd-wait-online.service
    systemctl mask systemd-networkd-wait-online.service
}

#===================================================
# Main Methods
function configure_settings() {
    prepare_apt
    disable_swap
    disable_snap
    set_ntp
    disable_system_flags
}

#===================================================
# Main
configure_settings
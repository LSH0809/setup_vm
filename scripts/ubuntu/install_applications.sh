#!/bin/bash

#===================================================
# Methods
function install_base_packages_ubuntu() {
    apt install -y curl \
        git \
        vim \
        htop \
        net-tools \
        policycoreutils \
        wget \
        unzip \
        ca-certificates
}

function install_ssh_server() {
    apt install -y openssh-server
}

function install_vmware_tools() {
    apt install -y open-vm-tools \
        open-vm-tools-desktop
}

function install_openjdk_17() {
    apt install -y openjdk-17-jdk
    echo "JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" >> /etc/environment
    source /etc/environment
    java -version
}

function install_python3() {
    apt install -y python3 \
        python3-pip
}

function install_microsfot_edge() {
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg
    chmod 644 /etc/apt/trusted.gpg.d/microsoft.gpg
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-stable.list

    apt update \
    && apt install -y microsoft-edge-stable
}

function install_vscode() {
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list

    apt update \
    && apt install -y code
}

function install_docker() {
    # Add Docker's official GPG key:
    apt-get update

    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt-get update

    apt-get install -y docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin
}

#===================================================
# Main Methods
function install_applications() {
    install_base_packages_ubuntu
    install_ssh_server
    install_vmware_tools
    install_openjdk_17
    install_python3
    install_microsfot_edge
    install_vscode
    install_docker
}

#===================================================
# Main
install_applications
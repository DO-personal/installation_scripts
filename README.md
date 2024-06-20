# Installation Scripts for Docker, Minikube, Kubernetes, Jenkins, and Ansible on Arch Linux

This repository provides individual scripts to automate the installation of Docker, Minikube, Kubernetes, Jenkins, and Ansible on an Arch Linux system.

## Tools Installed

- Docker
- Minikube
- Kubernetes (kubectl, kubelet, kubeadm)
- Jenkins
- Ansible

## Usage

### Prerequisites

Ensure that your system is up-to-date and that you have `curl` and `yay` installed. You can install `yay` from the AUR if you don't have it:

```sh
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#!/bin/bash

# Function to print a header
print_header() {
  echo
  echo "===================================================="
  echo "$1"
  echo "===================================================="
  echo
}

# Function to display a progress bar
progress_bar() {
  local duration=$1
  local interval=0.2
  local total_steps=$(bc <<<"$duration/$interval")
  local completed_steps=0

  while [ $completed_steps -lt $total_steps ]; do
    local percentage=$(bc <<<"scale=2; $completed_steps/$total_steps*100")
    local filled=$(bc <<<"$completed_steps*40/$total_steps")
    local empty=$(bc <<<"40-$filled")

    printf "\r["
    printf "%0.s#" $(seq 1 $filled)
    printf "%0.s-" $(seq 1 $empty)
    printf "] %0.2f%%" $percentage

    sleep $interval
    completed_steps=$(($completed_steps + 1))
  done

  printf "\n"
}

# Simulated task function to show progress bar
task_with_progress() {
  local task_name=$1
  local duration=$2
  print_header "$task_name"
  progress_bar $duration
}

# Install Docker
task_with_progress "Installing Docker" 5
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Install kubectl
task_with_progress "Installing kubectl" 5
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Install Minikube
task_with_progress "Installing Minikube" 5
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install -o root -g root -m 0755 minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# Start Minikube with Docker driver
task_with_progress "Starting Minikube" 5
minikube start --driver=docker

task_with_progress "Installation Complete" 2

# Verify the installation
print_header "Verifying Installation"
docker --version
minikube version
kubectl version --client
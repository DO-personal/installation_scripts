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

# Install Jenkins
task_with_progress "Installing Jenkins" 5
yay -S --noconfirm jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

task_with_progress "Jenkins Installation Complete" 2

# Verify the installation
print_header "Verifying Jenkins Installation"
jenkins --version
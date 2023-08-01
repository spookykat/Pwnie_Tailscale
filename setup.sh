#!/bin/bash
# This script is for installing Tailscale

# First, it fetches the GPG key for the Tailscale repository securely over HTTPS,
# pipes it to the tee command which both writes it to a file and outputs it to the standard output.
# The output is then discarded by redirecting it to /dev/null.
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null

# Second, it fetches the repository list file for Tailscale in a similar way,
# and adds it to the APT sources list.
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list

# Updates the package list for your system
apt-get update

# Force installs the Tailscale package, 
# '--yes' option to apt-get install will make it automatically answer yes to prompts
# '--force-yes' will force confirmation in some potentially risky situations, such as installing unsigned packages.
apt-get install --yes --force-yes tailscale

# Enables and starts the Tailscale daemon (tailscaled) immediately using systemd
systemctl enable --now tailscaled

# Enables and starts the SSH server immediately using systemd
systemctl enable --now ssh

# The final command logs this device into your Tailscale network. 
# Replace "KEY" with your actual Tailscale pre-authentication key.
tailscale up --authkey KEY
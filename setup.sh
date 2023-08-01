#!/bin/bash
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list

apt-get update
apt-get install --yes --force-yes tailscale 
systemctl enable --now tailscaled
systemctl enable --now ssh
tailscale up --authkey KEY
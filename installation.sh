#!/bin/bash

set -e

# Detect current user and home directory
USER_NAME=$(whoami)
USER_HOME=$(eval echo "~$USER_NAME")

echo "[INFO] Installing K3s without Traefik..."
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--cluster-init --disable=traefik" sh -

echo "[INFO] Copying kubeconfig from /etc/rancher/k3s/k3s.yaml..."
sudo cp -r /etc/rancher/k3s/k3s.yaml "$USER_HOME/.kube/config"

echo "[INFO] Changing ownership of kubeconfig to $USER_NAME..."
sudo chown "$USER_NAME:$USER_NAME" "$USER_HOME/.kube/config"

echo "[INFO] Exporting KUBECONFIG for current session..."
export KUBECONFIG="$USER_HOME/.kube/config"

echo "[INFO] Done! You can now run kubectl commands."

#!/bin/bash
echo "### Destroying Kubernetes Cluster (CentOS)."
echo "Deleting Vagrant Boxes (CentOS VMs)..."
cd vagrant
sudo vagrant destroy
sudo ssh-keygen -R 10.11.12.2
sudo ssh-keygen -R 10.11.12.3
sudo ssh-keygen -R 10.11.12.4




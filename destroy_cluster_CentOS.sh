#!/bin/bash
echo "#"
echo "### Destroying Kubernetes Cluster (CentOS)."
echo "#"
echo ""
echo "# Deleting Vagrant Boxes (CentOS VMs)..."
cd vagrant/centos
sudo vagrant destroy
sudo ssh-keygen -R 10.11.12.2
sudo ssh-keygen -R 10.11.12.3
sudo ssh-keygen -R 10.11.12.4




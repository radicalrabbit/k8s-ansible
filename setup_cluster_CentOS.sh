#!/bin/bash
echo "### Installing Kubernetes Cluster (CentOS)."
echo "Preparing Vagrant Boxes (CentOS VMs)..."
cd vagrant
sudo vagrant destroy
sudo vagrant up
cd ..
echo "Installing Kubernetes Nodes (1 Master, 2 Workers)..."
cd centos
sudo ansible-playbook setup_master_node.yml
sudo ansible-playbook setup_worker_nodes.yml
echo "Installing Kubernetes Dashboard..."
sudo ansible-playbook setup_dashboard.yml



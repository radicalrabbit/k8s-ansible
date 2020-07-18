#!/bin/bash
echo "### Installing Kubernetes Cluster (CentOS)."
echo "Preparing Vagrant Boxes (CentOS VMs)..."
cd vagrant
sudo vagrant destroy
sudo ssh-keygen -R 10.11.12.2
sudo ssh-keygen -R 10.11.12.3
sudo ssh-keygen -R 10.11.12.4
sudo vagrant up
sleep 5
cd ..
echo "Installing Kubernetes Master-Node..."
cd centos
sudo ansible-playbook setup_master_node.yml
echo "Installing Kubernetes Dashboard..."
sudo ansible-playbook setup_dashboard.yml
sleep 5
echo "Installing Kubernetes Worker Nodes (2 Nodes)..."
sudo ansible-playbook setup_worker_nodes.yml




#!/bin/bash
echo "#"
echo "### Installing Kubernetes Cluster (CentOS)."
echo "#"
echo ""
echo "#"
echo "# Preparing Vagrant Boxes (CentOS VMs)..."
echo "#"
cd vagrant
sudo vagrant destroy
sudo ssh-keygen -R 10.11.12.2
sudo ssh-keygen -R 10.11.12.3
sudo ssh-keygen -R 10.11.12.4
sudo vagrant up
cd ..
echo "#"
echo "# Installing Kubernetes Master-Node..."
echo "#"
cd centos
sudo ansible-playbook setup_master_node.yml -i hosts
cd ..
cd deployment
echo "#"
echo "# Installing Kubernetes Dashboard..."
echo "#"
sudo ansible-playbook setup_dashboard.yml -i ../centos/hosts 
cd ..
cd centos
echo "#"
echo "# Installing Kubernetes Worker Nodes (2 Nodes)..."
echo "#"
sudo ansible-playbook setup_worker_nodes.yml -i hosts




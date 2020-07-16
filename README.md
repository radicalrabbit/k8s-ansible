# Installing Vagrant
TBD
```
$ vagrant plugin install vagrant-libvirt
```

# Brief Vagrant Cheatsheet:

Get a list of all local Vagrant boxes:
```
$ vagrant global-status
```

Remove all local Vagrant boxes:
```
$ vagrant box list | cut -f 1 -d ' ' | xargs -L 1 vagrant box remove -f
```

Clear the local lost of Vagrant boxes:
```
$ vagrant global-status --prune
```

# Configuring the Host Addressesn

* Clone the repository: git clone https://github.com/radicalrabbit/k8s-ansible.git
* Create multiple servers (e.g. Centos). One master and 1-n workers. 
* Provide the 'ad_addr' in the env_variables file by setting the IP address of the Kubernetes 
* Add the IP Addresses of the worker nodes and the master node in the 'hosts' file.
* Proceed with the steps described below according to your OS (e.g. CentOS).

# Setup the Kubernetes Cluster with Ansible (Ubuntu 18.04)

## Prerequisites
The installation artifacts provided in this repository require an installation of Ansible (>= 2.9). Please execute the following commands inside a terminal console of your system:
```
$ sudo apt update && sudo apt upgrade -y
$ sudo apt install software-properties-common -y
$ sudo apt install python3
$ sudo apt install python3-pip
$ pip3 install openshift pyyaml kubernetes
$ sudo apt-add-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible -y
$ ansible --version
$ pip3 --version
```
After update and installation procedure have successfully completed the last of the commands above should deliver a command prompt similar to "ansible 2.9.*".

Beyond the software modules listed above the Ansible scripts also require a running SSH server demon on the target system. Check if a running SSH server is available on your system by executing the subsequent command:
```
$ systemctl status sshd
```
If you should get any other information that "active (running)" you will probably need to install and activate the SSH demon:
```
$ sudo apt-get install openssh-server
$ sudo apt-get install openssh-client
$ sudo systemctl status ssh
$ sudo ufw allow ssh
$ systemctl status sshd
```
## Install the k8s master node
TBD

## Install the k8s slave node(s)
TBD

# Setup the Kubernetes Cluster with Ansible (CentOS 8)

## Prerequisites
The installation artifacts provided in this repository require an installation of Ansible (>= 2.9). Please use the following commands inside a terminal console of your system (Note: Some of the subsequent commands must be confirmed using the "y" key):

```
# sudo dnf makecache
# sudo dnf install epel-release
# sudo dnf makecache
# sudo dnf install python3
# pip3 install openshift pyyaml kubernetes
# sudo dnf install ansible
# ansible --version
# pip3 --version
```
After update and installation procedure have successfully completed the last of the commands above should deliver a command prompt similar to "ansible 2.9.*".

Beyond the software modules listed above the Ansible scripts also require a running SSH server demon on the target system. Check if a running SSH server is available on your system by executing the subsequent command:
```
systemctl status sshd
```
If you should get any other information that "active (running)" you will probably need to install and activate the SSH demon:
```
# dnf install openssh-server
# systemctl start sshd
# systemctl enable sshd
# systemctl status sshd
# firewall-cmd --zone=public --permanent --add-service=ssh
# firewall-cmd --reload
# systemctl reload sshd
```

## Install the k8s master node
After installing Ansible you can start to work with the installatiob scripts provided in the Git repository:

* Clone the according GitHub repository: git clone https://github.com/radicalrabbit/k8s-ansible.git
```
# git config --global credential.helper store
# git pull
```
* Create one or multiple server nodes (CentOS and Ubuntu supported), e.g. one master and arbitrary slave-/worker-nodes (e.g. KVM,VirtualBox).
* Change the “ad_addr” in the env_variables file with the IP address of the Kubernetes master node.
* Add the IPs of the master and slave nodes in the according "hosts" file.
* Run the subsequent following commands to setup Kubernetes nodes and services.
```
# sudo ansible-playbook setup_master_node.yml
```

## Install the k8s slave node(s)
After the master node setup has finished, run the subsequent command to set up the k8s slave node(s).
```
# sudo ansible-playbook setup_worker_nodes.yml
```
Once the nodes have joined the cluster, run the following command to check the status of the respective slave nodes.
```
# kubectl get nodes
```

# Setup additional Kubernetes services using Ansible
TBD

## Kubernetes Dashboard
The installation of the k8s Dashboard service is automatically executed in the master nodes Ansible setup (Ansible file located in services/dashboard.yml). Check the following address to see if the dashboad web application is up and running:
```
$ http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```
The login procedure requires the admin security token of your k8s cluster. Either copy the token of your k8s setup from the command line output (k8s master node setup) or execute the subsequent command in a console window of ypur master node:
```
$ kubectl get secret $(kubectl get serviceaccount dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode
```
## Atlassian Jira
TBD
```
$
```

## Atlassian Confluence
TBD
```
$
```

## Atlassian Bitbucket
TBD
```
$
```

## Jenkins CI Build Server
TBD
```
$
```

## Nexus Artifact Management
TBD
```
$
```

## GitLab
I prefer to use Bitbucket for hosting my Git repositories. Nevertheless I also created a installation routine for a GitLab service inside the k8s cluster.
```
$
```

## K8s Cheatsheet
TBD
```
$ kubectl get nodes
```

TBD
```
$ kubectl get pods --all-namespaces
```

# Sources and References:
* https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu
* https://devopscube.com/setup-nexus-kubernetes/
* https://github.com/ctienshi/kubernetes-ansible
* https://www.edureka.co/blog/install-kubernetes-on-ubuntu
* https://linuxconfig.org/install-ssh-server-on-redhat-8
* https://linuxize.com/post/how-to-enable-ssh-on-ubuntu-18-04/
* https://phoenixnap.com/kb/install-kubernetes-on-ubuntu
* https://www.digitalocean.com/community/tutorials/so-installieren-und-verwenden-sie-docker-auf-ubuntu-18-04-de


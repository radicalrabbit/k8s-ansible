# Installing Vagrant
The Kubernetes node VMs in this project are created by using Vagrant box images. First of all please install Vagrant before proceeding with the next steps:

CentOS:
```
# sudo dnf -y install https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.rpm
# vagrant --version
# sudo vagrant plugin install vagrant-libvirt
```

Debian/Ubuntu:
```
$ curl -O https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.deb
$ sudo apt install ./vagrant_2.2.9_x86_64.deb
$ vagrant --version
$ sudo vagrant plugin install vagrant-libvirt
```

The virtual machines for the K8s cluster can also be installed manually. Nevertheless Vagrant is the perfect choice to create lightweight VMs in less time by using a reproducible installation process (see https://www.vagrantup.com/).

Note: I recommend to use at least 8Gb of RAM and 2 CPU cores for each cluster node (both master and worker nodes).

# Configuring the Host Addresses

* Clone the repository: git clone https://github.com/radicalrabbit/k8s-ansible.git
* Create multiple servers (e.g. Centos). One master and 1-n workers. 
* Provide the 'ad_addr' in the env_variables file by setting the IP address of the Kubernetes 
* Add the IP Addresses of the worker nodes and the master node in the 'hosts' file.
* Proceed with the steps described below according to your OS (e.g. CentOS).

# Prepare the Vagrant Boxes

![Alt text](img/3.png)
```
$ cd vagrant
$ sudo vagrant up
```

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
# kubectl get nodes -o wide
```

# Setup additional Kubernetes services using Ansible
TBD

## Kubernetes Dashboard
The installation of the k8s Dashboard service is automatically executed in the master nodes Ansible setup (Ansible file located in services/dashboard.yml). The login procedure requires the admin security token of your k8s cluster. Either copy the token of your k8s setup from the command line output (k8s master node setup) or execute the subsequent command in a console window of ypur master node:
```
$ sudo kubectl describe serviceaccount/dashboard
$ sudo kubectl describe secrets/dashboard-token-*****

```
The k8s dashboard should be available with an external browser (outside of the K8s network):

Look for the NodePort entry. In both commands you should find a result entry for the NodePort, usually a five digit port number (e.g. 30908):
```
$ sudo kubectl -n kube-system get services --all-namespaces
$ sudo kubectl describe services kubernetes-dashboard --namespace=kubernetes-dashboard
```

Take the port information from above and combine it with the k8s master IP:
```
$ https://10.11.12.2:30908/#/login
```
You will probably get a warning telling you that the SSL certifiacte is unsafe (unsigned). Accept and proceed to the login page of the dashboard.

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
I prefer to use Bitbucket for hosting my Git repositories. Nevertheless I also created an installation routine for a GitLab service inside the k8s cluster.
```
$
```

# Cheatsheet :: Useful commands
The following subsections describe some of the most frequent used commands in context of you Kubernetes cluster network.

## Vagrant
The following commands might be useful while playing around with the Vagrant machines.

Bring up Vagrant boxes:
```
$ sudo vagrant up
```

Get a list of all local Vagrant boxes:
```
$ sudo vagrant global-status
```

Remove all local Vagrant boxes:
```
$ sudo vagrant box list | cut -f 1 -d ' ' | xargs -L 1 vagrant box remove -f
```

Clear the local lost of Vagrant boxes:
```
$ sudo vagrant global-status --prune
```

Destroy known Vagrant boxes:

```
$ sudo vagrant destroy
```

Remove the known SSh keys, e.g. if one or multiple Vagrant boxes have been destroyed. This command will be necessary before re-creating a VM box, e.g. with the formerly used IP 10.11.12.2:
```
$ sudo ssh-keygen -R 10.11.12.2
```

## Kubernetes

The following command shows all K8s nodes which are currently connected to the cluster network:
```
$ sudo kubectl get nodes
```

The following command also shows all K8s nodes which are currently connected to the cluster network, including some more detailed information on the nodes (e.g. label and node type):
```
$ sudo kubectl get nodes --show-labels
```

Assign a role label to a certain node (e.g. master or worker):
```
$ sudo kubectl label node centos82  node-role.kubernetes.io/master=master
$ sudo kubectl label node centos83  node-role.kubernetes.io/worker=worker
$ sudo kubectl label node centos84  node-role.kubernetes.io/worker=worker
```

This command collects cluster node information, e.g. available RAM and CPU. The command below provides all available information for node "centos82":
```
$ sudo kubectl describe node centos82
```

Get all running K8s pods in all known namespaces:
```
$ sudo kubectl get pods --all-namespaces
```

With this command you can watch the K8s container creation process. The following command refreshes the results list for "flannel" pods every 2.0 seconds:
```
$ sudo watch kubectl get pods -n flannel

```
The command above can also be used for other pods and namespaces (e.g. all namespaces):
```
sudo watch kubectl get pods --all-namespaces
```

The subsequent commands lists all known K8s services in the currently known namespaces:
```
$ sudo kubectl get services --all-namespaces
```

Deleting a deployment, e.g. the K8s dashboard:
```
$ kubectl delete deployment kubernetes-dashboard --namespace=kube-system.
```

Get information on a deploymnet failure (e.g. dashboard pod):
```
$ sudo kubectl -n kubernetes-dashboard describe pod kubernetes-dashboard-7f99b75bf4-6jblg
```

# Sources and References:
* https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu
* https://devopscube.com/setup-nexus-kubernetes/
* https://github.com/ctienshi/kubernetes-ansible
* https://www.edureka.co/blog/install-kubernetes-on-ubuntu
* https://www.edureka.co/blog/kubernetes-dashboard/
* https://linuxconfig.org/install-ssh-server-on-redhat-8
* https://linuxize.com/post/how-to-enable-ssh-on-ubuntu-18-04/
* https://phoenixnap.com/kb/install-kubernetes-on-ubuntu
* https://www.digitalocean.com/community/tutorials/so-installieren-und-verwenden-sie-docker-auf-ubuntu-18-04-de
* https://github.com/kubernetes/dashboard/releases
* https://docs.projectcalico.org/getting-started/kubernetes/quickstart


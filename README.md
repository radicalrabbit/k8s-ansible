# Setup the Kubernetes Cluster with Ansible (Ubuntu)
TBD

# Setup the Kubernetes Cluster by using Ansible (CentOS)
* Clone the repository: git clone https://github.com/radicalrabbit/k8s-ansible.git
```
git config --global credential.helper store
git pull
```
* Create one or multiple server nodes (CentOS and Ubuntu supported), e.g. one master and arbitrary slave-/worker-nodes (e.g. KVM,VirtualBox).
* Change the “ad_addr” in the env_variables file with the IP address of the Kubernetes master node.
* Add the IPs of the master and slave nodes in the according "hosts" file.
* Run the subsequent following commands to setup Kubernetes nodes and services.
```
ansible-playbook setup_master_node.yml --ask-pass
```
* After the master node setup has finished, run the subsequent command to set up the k8s slave nodes.
```
ansible-playbook setup_worker_nodes.yml --ask-pass
```
* Once the workers have joined the cluster, run the following command to check the status of the worker nodes.
```
kubectl get nodes
```

# Setup additional Kubernetes services using Ansible
TBD

## Kubernetes Dashboard
The installation of the k8s Dashboard service is automatically executed in the master nodes Ansible setup (Ansible file located in services/dashboard.yml). Check the following address to see if the dashboad web application is up and running:
```
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```
The login procedure requires the admin security token of your k8s cluster. Either copy the token of your k8s setup from the command line output (k8s master node setup) or execute the subsequent command in a console window of ypur master node:
```
kubectl get secret $(kubectl get serviceaccount dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode
```

# Sources and References:
* https://devopscube.com/setup-nexus-kubernetes/
* https://github.com/ctienshi/kubernetes-ansible
* https://www.edureka.co/blog/install-kubernetes-on-ubuntu


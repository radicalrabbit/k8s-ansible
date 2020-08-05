sudo yum install -y python3

set -e -u

# disable selinux sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
setenforce 0 
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

# disable firewalld 
systemctl disable firewalld
# enable vagrant PasswordAuthentication
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
modprobe br_netfilter
reboot

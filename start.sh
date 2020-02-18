#!/bin/bash
#Initial script to management of k8s in the system.
echo "To start process to set selinux,iptables Press 1: " 
echo "To install kubernetes and docker packages Press 2: " 
echo "To open all ports of firewall Press 3: "
echo "To enable and restart service of docker and kubelet Press 4:"
echo "To set kubernetes bash completion Press 5:"
echo "To set kubeadm network, applicable only in "MasterNode" Press 6: "
echo "To set kubernetes admin.conf, applicable only in "MasterNode" Press 7: "
echo "To install calico configuration, applicable only in "MasterNode" Press 8: "
read -r value

if [ "$value" == 1 ];then
	setenforce 0
	sed -i 's/SELINUX=enforcing/SELINUX=disabled/'  /etc/selinux/config
	modprobe br_netfilter
	echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
 	swapoff  -a
elif [ "$value" == 2 ];then
        echo "[name]" >> /etc/yum.repos.d/kubernetes.repo
        echo "baseurl=ftp://192.168.10.254/pub/winter19-20/kubernetes/" >> /etc/yum.repos.d/kubernetes.repo
        echo "gpgcheck=0" >> /etc/yum.repos.d/kubernetes.repo
	yum clean all && yum repolist all
	yum  install docker kubeadm  -y
elif [ "$value" == 3 ];then
	firewall-cmd --add-port=0-65535/udp --permanent
        firewall-cmd --add-port=0-65535/tcp --permanent
        firewall-cmd --reload
elif [ "$value" == 4 ];then
	systemctl enable --now  docker kubelet
elif [ "$value" == 5 ];then
	yum install bash-completion -y
	echo "source <(kubectl completion bash)" >> ~/.bashrc
	source /root/.bashrc
        bash
elif [ "$value" == 6 ];then
	kubeadm  init --pod-network-cidr=192.168.0.0/16 >> tokenfile.txt && tail -n 5 tokenfile.txt 
elif [ "$value" == 7 ];then
	mkdir -p $HOME/.kube
        cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
	chown $(id -u):$(id -g) $HOME/.kube/config
elif [ "$value" == 8 ];then
	kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml

fi



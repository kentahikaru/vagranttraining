#turn off swap
sudo swapoff -a

#apt-get upgrade
apt-get install -y git ansible mc screen

#install docker
#sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

#sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

#install kubernetes
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update

#on master
sudo apt-get install -y kubectl kubelet kubeadm
#on node
#sudo apt-get install -y kubectl

sudo systemctl enable kubelet && sudo systemctl start kubelet

#disable swap in /etc/fstab on master and nodes

#init with flannel  
#https://opensource.com/article/20/6/kubernetes-raspberry-pi
# sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --control-plane-endpoint 172.16.0.21

#mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config

#apply flannel
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.13.0/Documentation/kube-flannel.yml
#apply flannel for vagrant

#vagrant & flannel troubleshooting
# https://coreos.com/flannel/docs/latest/troubleshooting.html

#fix flannel on node
# kubectl patch node node1 -p '{"spec":{"podCIDR":"10.244.0.0/16"}}'



#apply network CNI on master
#kubectl apply -f https://docs.projectcalico.org/v2.6/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml

#install calico on master
# https://docs.projectcalico.org/getting-started/kubernetes/quickstart


#issue for node join
#https://github.com/kubernetes/kubernetes/issues/58876



# to "delete"/reset master/node
# sudo kubeadm reset
# rm -r ~/.kube/*
# /etc/cni/net.d
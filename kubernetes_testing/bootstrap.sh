#turn off swap
sudo swapoff -a
#disable swap in /etc/fstab on master and nodes

#sudo apt-get upgrade
sudo apt-get install -y git ansible mc screen net-tools links

#install NFS -- https://www.raspberrypi.org/documentation/configuration/nfs.md
#on master
sudo apt install nfs-kernel-server
#set up /etc/exports
sudo systemctl restart nfs-kernel-server
#on node
sudo apt install nfs-common
#mount -t nfs -o proto=tcp,port=2049 <nfs-server-IP>:/ /mnt


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

#install kubernetes  -- book and https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update

#on master
sudo apt-get install -y kubectl kubelet kubeadm
#on node
#sudo apt-get install -y kubelet

sudo systemctl enable kubelet && sudo systemctl start kubelet



#init with flannel  
#https://opensource.com/article/20/6/kubernetes-raspberry-pi
# sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --control-plane-endpoint=172.16.0.21 --apiserver-advertise-address=172.16.0.21

# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config

#apply flannel
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
#apply flannel for vagrant with added --iface=eth1
# kubectl apply -f kube-flannel.yml





#######
#vagrant & flannel troubleshooting
# https://coreos.com/flannel/docs/latest/troubleshooting.html
# https://github.com/kubernetes/kubernetes/issues/39701

#fix flannel on node
# kubectl patch node node1 -p '{"spec":{"podCIDR":"10.244.0.0/16"}}'

#issue for node join
#https://github.com/kubernetes/kubernetes/issues/58876

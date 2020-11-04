sudo kubeadm reset
rm -r ~/.kube/*
sudo rm /etc/cni/net.d/*
echo "" > ~/cluster
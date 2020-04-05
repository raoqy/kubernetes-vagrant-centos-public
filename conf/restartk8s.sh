sudo -s 
systemctl stop kube-proxy
systemctl stop kubelet
systemctl stop kube-scheduler
systemctl stop kube-controller-manager
systemctl stop kube-apiserver
systemctl stop docker
systemctl stop etcd
echo "start k8s"
systemctl start etcd
systemctl start docker
systemctl start kube-apiserver
systemctl start kube-controller-manager
systemctl start kube-scheduler
systemctl start kubelet
systemctl start kube-proxy

#!/usr/bin/env bash

#Get and install cfssl

mkdir -p /opt/k8s/bin
mkdir -p /opt/k8s/work && cd /opt/k8s/work

wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
chmod +x cfssl_linux-amd64
mv cfssl_linux-amd64 /opt/k8s/bin/cfssl

wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
chmod +x cfssljson_linux-amd64
mv cfssljson_linux-amd64 /opt/k8s/bin/cfssljson

wget https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64
chmod +x cfssl-certinfo_linux-amd64
mv cfssl-certinfo_linux-amd64 /opt/k8s/bin/cfssl-certinfo

cp -f /vagrant/pki/* ./
export PATH=/opt/k8s/bin:$PATH
echo "PATH is $PATH ........"

#generate kubernetes pem
echo "generate kubernetes certificate"
$ cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kubernetes-csr.json | cfssljson -bare kubernetes
$ ls kubernetes*
kubernetes.csr  kubernetes-csr.json  kubernetes-key.pem  kubernetes.pem

#vertify the kubernetes pem 
cfssl-certinfo -cert kubernetes.pem


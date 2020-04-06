# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.provider 'virtualbox' do |vb|
   vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]
  end  
  #config.vm.synced_folder ".", "/vagrant", type: "nfs", nfs_udp: false
  $num_instances = 1
  # curl https://discovery.etcd.io/new?size=3
  $etcd_cluster = "node1=http://192.168.101.101:2380"
  (1..$num_instances).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.box = "centos/7"
      node.vm.hostname = "node#{i}"
      ip = "192.168.101.101"
      #node.vm.network "private_network", ip: ip
	  
      #公开的网络，桥接到本地wifi的网络接口 
      node.vm.network "public_network", auto_config: false, bridge: "Intel(R) Dual Band Wireless-AC 8265"
        
      node.vm.provider "virtualbox" do |vb|
          vb.memory = "1536"
          vb.cpus = 1
          vb.name = "node#{i}"
      end
      
      # 初始化网络设置(IP、掩码、网关、DNS等)
      node.vm.provision "shell", path: "network/initnetwork.sh", args: [i]
      
      #初始化kubernetes的设置
      node.vm.provision "shell", path: "install.sh", args: [i, ip, $etcd_cluster]
    end
  end
end

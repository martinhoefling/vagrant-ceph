# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 1
    vb.memory = "512"
  end

  config.vm.define "ceph-admin" do |hostconfig|
    hostconfig.vm.hostname = "ceph-admin"
    hostconfig.vm.network "private_network", ip: "192.168.1.2"
    hostconfig.vm.provision "shell", path: "bootstrap-admin.sh"
    hostconfig.vm.provider "virtualbox" do |vb|
      vb.name = "ceph-admin"
    end
  end

  (1..1).each do |i|
    config.vm.define "ceph-mon#{i}" do |hostconfig|
      hostconfig.vm.hostname = "ceph-mon#{i}"
      hostconfig.vm.network "private_network", ip: "192.168.1.#{i+50}"
      hostconfig.vm.provision "shell", path: "bootstrap-mon.sh"
      hostconfig.vm.provider "virtualbox" do |vb|
        vb.name = "ceph-mon#{i}"
      end
    end
  end

  (1..1).each do |i|
    config.vm.define "ceph-mds#{i}" do |hostconfig|
      hostconfig.vm.hostname = "ceph-mds#{i}"
      hostconfig.vm.network "private_network", ip: "192.168.1.#{i+150}"
      hostconfig.vm.provision "shell", path: "bootstrap-mds.sh"
      hostconfig.vm.provider "virtualbox" do |vb|
        vb.name = "ceph-mds#{i}"
      end
    end
  end

  (1..3).each do |i|
    config.vm.define "ceph-osd#{i}" do |hostconfig|
      hostconfig.vm.hostname = "ceph-osd#{i}"
      hostconfig.vm.network "private_network", ip: "192.168.1.#{i+100}"
      hostconfig.vm.provision "shell", path: "bootstrap-osd.sh"
      hostconfig.vm.provider "virtualbox" do |vb|
        unless File.exist?("ceph_osd_storage#{i}.vdi")
          vb.customize ['createhd', '--filename', "ceph_osd_storage#{i}", '--size', 10 * 1024]
        end
        vb.customize ['storageattach', :id, '--storagectl', 'SATAController', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', "ceph_osd_storage#{i}.vdi"]
        vb.name = "ceph-osd#{i}"
      end
    end
  end
end

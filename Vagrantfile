# coding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos/7"
  config.vm.hostname = "zen-dev"
  # virtual setting
  config.vm.provider "virtualbox" do |vm|
    # set default memory to 1024MB
    vm.customize ["modifyvm", :id, "--memory", "1024"]
  end
  # django
  config.vm.network :forwarded_port, guest: 80, host: 80
  config.vm.network :forwarded_port, guest: 443, host: 443
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 3001, host: 3001
  # util-samba-ad
  config.vm.network :forwarded_port, guest: 389, host: 389
  # storage-zenko
  config.vm.network :forwarded_port, guest: 8001, host: 8001
  # web-adminer
  config.vm.network :forwarded_port, guest: 8002, host: 8002
  # storage-mariadb-batch
  config.vm.network :forwarded_port, guest: 8003, host: 8003
  # mailhog
  config.vm.network :forwarded_port, guest: 8025, host: 8025
  # selenium-hub
  config.vm.network :forwarded_port, guest: 4444, host: 4444
  # mariadb
  config.vm.network :forwarded_port, guest: 32767, host: 32767
  # storage-mariadb-batch
  config.vm.network :forwarded_port, guest: 32766, host: 32766
  # redis
  config.vm.network :forwarded_port, guest: 6379, host: 6379
  # mount point
  config.vm.synced_folder "./", "/var/project/zen/development-environment/app/src/", :mount_options => ["dmode=777,fmode=666"]
  # script to install docker
  config.vm.provision "shell", inline: <<-SHELL

    yum install -y yum-utils device-mapper-persistent-data lvm2
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    yum install -y docker-ce
    systemctl start docker
    systemctl enable docker
    curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

  SHELL
  # script to run docker-compose
  config.vm.provision :shell, :inline => "cd /var/project/zen/development-environment/app/src/; /usr/local/bin/docker-compose up -d", run: "always"
end

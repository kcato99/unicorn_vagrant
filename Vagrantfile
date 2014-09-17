# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos65"
  # ローカルに無ければ取ってくる
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--name", "unicorn_box", "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
  end

  config.vm.boot_timeout = 900
  config.vm.hostname = "unicorn"
  config.vm.network "private_network", ip: "192.168.32.10"

  load_path = File.dirname(__FILE__) + '/../'
  config.vm.synced_folder load_path + "app", "/srv/web/current", :mount_options => ["dmode=777", "fmode=777"]
  config.hostsupdater.aliases = ["unicorn.local"]
  config.exec.commands '*', directory: '/srv/web/current'
  Encoding.default_external = 'UTF-8'
end

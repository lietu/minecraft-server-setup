# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Configure how much memory to give to the VM
MEMORY_AMOUNT = "2048"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "ubuntu/trusty64"

    config.vm.boot_timeout = 30

    config.ssh.forward_agent = true

    # Define the vm
    vm_name = "minecraft"
    config.vm.define vm_name do |minecraft|
        minecraft.vm.hostname = vm_name
        minecraft.vm.network :private_network, ip: "172.31.31.31"

        minecraft.vm.synced_folder ".", "/src/"
        minecraft.vm.synced_folder "salt/roots/", "/srv/"

        minecraft.vm.provider "virtualbox" do |v|
            v.name = vm_name
            v.customize ["modifyvm", :id, "--memory", MEMORY_AMOUNT]
        end

        minecraft.vm.provision :salt do |config|
            config.minion_config = "salt/minion.conf"
            config.run_highstate = true
            config.verbose = true
            config.bootstrap_options = "-D"
            config.temp_config_dir = "/tmp"
        end
    end
end

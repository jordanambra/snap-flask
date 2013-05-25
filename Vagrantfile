# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "raring"
    config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"

    config.omnibus.chef_version = :latest

    config.berkshelf.enabled = true
    config.berkshelf.berksfile_path = "./config/Berksfile"

    config.vm.synced_folder "./config/", "/etc/app/config"
    config.vm.synced_folder "./app/", "/srv/app"

    config.vm.define :lb do |lb1|
        lb1.vm.hostname = "lb1"
        lb1.vm.network :private_network, ip: "192.168.50.1"
        lb1.vm.network :forwarded_port, guest: 80, host: 8080

        lb1.vm.provider :virtualbox do |vb|
            vb.name = "lb1"
            vb.customize ["modifyvm", :id, "--memory", "256"]
        end

        lb1.vm.provision :chef_solo do |chef|
            chef.roles_path = "./config/roles"
            chef.data_bags_path = "./config/data_bags"
            chef.add_role "balancer"
        end

        lb1.vm.provision :shell, :path => "./config/roles/balancer.sh"
    end

    config.vm.define :db do |db|
        db.vm.box = "raring"
        db.vm.hostname = "db1"
        db.vm.network :private_network, ip: "192.168.50.2"
        db.vm.network :forwarded_port, guest: 5432, host: 5432
        db.vm.synced_folder "./config/", "/etc/app/config"
        db.vm.synced_folder "./app/", "/srv/app"

        db.vm.provider :virtualbox do |vb|
          vb.name = "db1"
          vb.customize ["modifyvm", :id, "--memory", "1024"]
        end

        db.vm.provision :chef_solo do |chef|
            chef.roles_path = "./config/roles"
            chef.data_bags_path = "./config/data_bags"
            chef.json = { :postgres_password => "password" }

            chef.add_role "database"
        end

        db.vm.provision :shell, :path => "./config/roles/database.sh"
    end

    web_servers = {
        :web1 => ['192.168.50.101', 8000],
        :web2 => ['192.168.50.102', 8001]
    }

    web_servers.each do |server, server_ip|
        config.vm.define server do |web_config|
            web_config.vm.box = "raring"

            web_config.vm.hostname = server.to_s
            web_config.vm.network :private_network, ip: server_ip[0]
            web_config.vm.network :forwarded_port, guest: 80, host: server_ip[1]
            web_config.vm.synced_folder "./config/", "/etc/app/config"
            web_config.vm.synced_folder "./app/", "/srv/app"

            web_config.vm.provider :virtualbox do |vb|
                vb.name = server.to_s
                vb.customize ["modifyvm", :id, "--memory", "1024"]
            end

            web_config.vm.provision :chef_solo do |chef|
                chef.roles_path = "./config/roles"
                chef.data_bags_path = "./config/data_bags"
                chef.add_role "web"
            end

            web_config.vm.provision :shell, :path => "./config/roles/web.sh"
        end

    end
    
end

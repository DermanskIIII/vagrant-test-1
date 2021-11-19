# -*- mode: ruby -*-
# vi: set ft=ruby :
 
VAGRANTFILE_API_VERSION = "2"

#in this array enumerates all nodes
db_ip = "192.168.56.10"
bouncer_ip = "192.168.56.20"
backends = [ 
          { hostname: 'app1', address: '192.168.56.11' }, 
          { hostname: 'app2', address: '192.168.56.12' },
#          { hostname: 'app3', address: '192.168.56.13' },
#          { hostname: 'app4', address: '192.168.56.14' },
]

app_nodes = []
backends.cycle(1) { |server| app_nodes.append(server[:hostname]) }

Vagrant.configure("2") do |config|
  config.vm.define "bouncer" do |bouncer|
	  bouncer.vm.box = "generic/centos7"
	  bouncer.vm.provider "libvirt" do |v|
	  	v.memory = 512
   	  v.cpus = 1
   	end
	  bouncer.vm.network "private_network", ip: bouncer_ip
	  bouncer.vm.provision "ansible" do |ansible|
	    ansible.playbook = "bouncer.yaml"
	    ansible.groups = {
	      "node_bouncer" => ["bouncer"]
	    }
	    ansible.extra_vars = {
        "hostname" => 'bouncer',
      	"backends" => backends
    	}
    end
	end

  config.vm.define "database" do |database|
	  database.vm.box = "generic/centos7"
	  database.vm.provider "libvirt" do |v|
	  	v.memory = 512
   	  v.cpus = 1
   	end
	  database.vm.network "private_network", ip: db_ip
	  database.vm.provision "ansible" do |ansible|
	    ansible.playbook = "database.yaml"
	    ansible.groups = {
	      "node_database" => ["database"]
	    }
	    ansible.extra_vars = {
        "hostname" => "database",
      	"backends" => backends
    	}
    end
	end

  backends.length.times do |i|
    node_hostname = backends[i][:hostname]
    node_ip = backends[i][:address]
    config.vm.define node_hostname do |app|
  	  app.vm.box = "generic/centos7"
    	app.vm.provider "libvirt" do |v|
  	  	v.memory = 512
     	  v.cpus = 1
     	end
    	app.vm.network "private_network", ip: node_ip
      app.vm.provision "ansible" do |ansible|
  	    ansible.playbook = "app.yaml"
  	    ansible.groups = {
  	      "app_nodes" => app_nodes
  	    }
  	    ansible.extra_vars = {
          "hostname" => backends[i][:hostname],
          "bouncer_ip" => bouncer_ip,
          "db_ip" => db_ip,
          "db_user" => "testuser",
          "db_pass" => "12345"
      	}
      end
    end
  end
end
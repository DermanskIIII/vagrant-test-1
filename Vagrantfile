Vagrant.configure("2") do |config|
  config.vm.define "bouncer" do |bouncer|
	  bouncer.vm.box = "generic/centos7"
	  bouncer.vm.provider "libvirt" do |v|
	  	v.memory = 512
   	  v.cpus = 1
   	end
	  bouncer.vm.network "private_network", ip: "192.168.56.20"
	  bouncer.vm.network "forwarded_port", guest: 5000, host: 8080
	  bouncer.vm.provision "ansible" do |ansible|
	    ansible.playbook = "bouncer.yaml"
	    ansible.limit = "bouncer"
	    ansible.groups = {
	      "node_bouncer" => ["bouncer"]
	    }
	    ansible.extra_vars = {
        "hostname" => 'bouncer',
      	"backends" => [ 
      		{ name: 'app1', address: '192.168.56.11' }, 
      		{ name: 'app2', address: '192.168.56.12' }
      	]
    	}
    end
	end

  config.vm.define "database" do |database|
	  database.vm.box = "generic/centos7"
	  database.vm.provider "libvirt" do |v|
	  	v.memory = 512
   	  v.cpus = 1
   	end
	  database.vm.network "private_network", ip: "192.168.56.10"
	  database.vm.provision "ansible" do |ansible|
	    ansible.playbook = "database.yaml"
	    ansible.limit = "database"
	    ansible.groups = {
	      "node_database" => ["database"]
	    }
	    ansible.extra_vars = {
        "hostname" => 'database',
      	"allowed_ip" => [ 
      		'192.168.56.11', 
      		'192.168.56.12'
      	]
    	}
    end
	end
  config.vm.define "app1" do |app1|
	  app1.vm.box = "generic/centos7"
  	app1.vm.provider "libvirt" do |v|
	  	v.memory = 512
   	  v.cpus = 1
   	end
  	app1.vm.network "private_network", ip: "192.168.56.11"
    app1.vm.provision "ansible" do |ansible|
	    ansible.playbook = "app.yaml"
	    ansible.limit = "node_app"
	    ansible.groups = {
	      "node_app" => ["app1"]
	    }
	    ansible.extra_vars = {
        "hostname" => 'app1',
        "bouncer_ip" => '192.168.0.20',
        "db_ip" => '192.168.56.10',
        "db_user" => 'testuser',
        "db_pass" => '12345'
    	}
    end
  end
  config.vm.define "app2" do |app2|
    app2.vm.box = "generic/centos7"
  	app2.vm.provider "libvirt" do |v|
	  	v.memory = 512
   	  v.cpus = 1
   	end
  	app2.vm.network "private_network", ip: "192.168.56.12"
		app2.vm.provision "ansible" do |ansible|
	    ansible.playbook = "app.yaml"
	    ansible.limit = "node_app"
	    ansible.groups = {
	      "node_app" => ["app2"]
	    }
	    ansible.extra_vars = {
        "hostname" => 'app2',
        "bouncer_ip" => '192.168.0.20',      	
        "db_ip" => '192.168.56.10',
      	"db_user" => 'testuser',
      	"db_pass" => '12345'
    	}
    end
	end


end
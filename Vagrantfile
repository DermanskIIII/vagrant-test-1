Vagrant.configure("2") do |config|
  config.vm.define "haproxy" do |haproxy|
	  haproxy.vm.box = "generic/centos7"
	  haproxy.vm.provider "libvirt" do |v|
	  	v.memory = 512
   	  v.cpus = 1
   	end
	  haproxy.vm.network "private_network", ip: "192.168.56.20"
	  haproxy.vm.network "forwarded_port", guest: 5000, host: 8080
	  haproxy.vm.provision "ansible" do |ansible|
	    ansible.playbook = "bouncer.yaml"
	    ansible.limit = "haproxy"
	    ansible.groups = {
	      "node_bouncer" => ["haproxy"]
	    }
	    ansible.extra_vars = {
      	"backends" => [ 
      		{ name: 'app1', address: '192.168.56.11' }, 
      		{ name: 'app2', address: '192.168.56.12' }, 
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
	    	"db_ip" => '192.168.56.10',
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
  	app1.vm.network "forwarded_port", guest: 5000, host: 8081
		app1.vm.provision "ansible" do |ansible|
	    ansible.playbook = "app.yaml"
	    ansible.limit = "app1"
	    ansible.groups = {
	      "node_app" => ["app1"]
	    }
	    ansible.extra_vars = {
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
  	app2.vm.network "forwarded_port", guest: 5000, host: 8082
		app2.vm.provision "ansible" do |ansible|
	    ansible.playbook = "app.yaml"
	    ansible.limit = "app2"
	    ansible.groups = {
	      "node_app" => ["app2"]
	    }
	    ansible.extra_vars = {
      	"db_ip" => '192.168.56.10',
      	"db_user" => 'testuser',
      	"db_pass" => '12345'
    	}
    end
	end


end
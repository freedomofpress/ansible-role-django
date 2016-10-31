Vagrant.configure('2') do |config|
  config.cache.scope = 'machine' if Vagrant.has_plugin?('vagrant-cachier')
  config.vm.box = 'debian/jessie64'
    
  config.vm.provider 'virtualbox' do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

  config.vm.define 'djangoserver' do |c|
    c.vm.hostname = 'djangoserver'
    c.vm.network 'private_network', type: 'dhcp', auto_config: true
    c.vm.network 'forwarded_port', guest: 443, host: 4443
    c.vm.network 'forwarded_port', guest: 80, host: 8080
    c.vm.synced_folder 'app-src/', '/var/www/django', type: 'rsync'
    c.vm.synced_folder ".", "/vagrant", disabled: true

    c.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbook.yml"
    end
  end

  
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision "shell", path: 'bootstrap/provision.sh'
  config.vm.provision "file",  source: 'bootstrap/update-elvis.sh', destination: '/home/vagrant/update-elvis.sh'
end

Vagrant.configure("2") do |config|
  # Definição da VM para o servidor web
  config.vm.define "web_server" do |web|
    web.vm.box = "ubuntu/focal64"
    web.vm.network "private_network", type: "dhcp"
    web.vm.provision "shell", path: "vagrant/web_provision.sh"
  end

  # Definição da VM para o servidor de banco de dados
  config.vm.define "database_server" do |db|
    db.vm.box = "ubuntu/focal64"
    db.vm.network "private_network", type: "dhcp"
    db.vm.provision "shell", path: "provision/web_provision.sh"
  end
end

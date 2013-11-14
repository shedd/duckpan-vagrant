# -*- mode: ruby -*-
# vi: set ft=ruby :

CUSTOM_CONFIG = {
                  "BOX_NAME"  =>  "precise64", 
                  "BOX_URL"   =>  "http://files.vagrantup.com/precise64.box", 
                  "HEADLESS"  =>  false, 
                  "DDG_PATH"  =>  "/Users/shedd/Dropbox/App_Xray/DuckDuckGo/repos"
                }

Vagrant.configure("2") do |config|
  # Change this to the name of your Vagrant base box.
  config.vm.box = CUSTOM_CONFIG['BOX_NAME']

  # Change this to a URL from which the base box can be downloaded, if you like.
  config.vm.box_url = CUSTOM_CONFIG['BOX_URL']

  # 'duckpan server' runs a development server on port 5000, so this forwards
  # that port to make it accessible.
  config.vm.network :forwarded_port, guest: 5000, host: 5000

  # headless?  uncomment this to have the VM's window available
  config.vm.provider :virtualbox do |vb|
    vb.gui = CUSTOM_CONFIG['HEADLESS']
  end

  # ran into problems with the perl package installation - apt-get update needed
  config.vm.provision "shell", inline: "sudo apt-get update"
  # make wasn't installed
  config.vm.provision "shell", inline: "sudo apt-get -y install build-essential"

  # Enable provisioning with chef solo, using the included cookbooks.  The
  # duckpan::default recipe sets up some dependencies and calls the included
  # duckpan.sh shell script.
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = './cookbooks'
    chef.add_recipe 'duckpan'
  end

  # setup synced folder for the DDG code: "local host machine path", "path on guest vm"
  # NOTE: If you change the guest VM path from /code edit the find command in duckpan.sh
  config.vm.synced_folder CUSTOM_CONFIG['DDG_PATH'], "/code"
end

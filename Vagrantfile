# -*- mode: ruby -*-
# vi: set ft=ruby :

CUSTOM_CONFIG = {
                  "BOX_NAME"  =>  "precise64", 
                  "BOX_URL"   =>  "http://files.vagrantup.com/precise64.box", 
                  "HEADLESS"  =>  false, 
                  "DDG_PATH"  =>  "~/DuckDuckGo/repos"
                }

Vagrant.configure("2") do |config|
  # Change this to the name of your Vagrant base box.
  config.vm.box = CUSTOM_CONFIG['BOX_NAME']

  # Change this to a URL from which the base box can be downloaded, if you like.
  config.vm.box_url = CUSTOM_CONFIG['BOX_URL']

  # enable Berkshelf integration for Chef cookbook management
  config.berkshelf.enabled = true

  # 'duckpan server' runs a development server on port 5000, so this forwards
  # that port to make it accessible.
  config.vm.network :forwarded_port, guest: 5000, host: 5000

  # headless?  uncomment this to have the VM's window available
  config.vm.provider :virtualbox do |vb|
    vb.gui = CUSTOM_CONFIG['HEADLESS']
  end

  # ran into problems with the package installation - make sure we have the most recent package urls
  config.vm.provision "shell", inline: "sudo apt-get update"
  # upgrade version of ruby to 1.9.3 - necessary for dmg cookbook: https://github.com/opscode-cookbooks/dmg/pull/14
  # config.vm.provision "shell", inline: "sudo apt-get install -y curl"
  # config.vm.provision "shell", inline: "curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3"
  # config.vm.provision "shell", inline: "/usr/local/rvm/bin/rvm --default use 1.9.3"

  # Enable provisioning with chef solo, using the included cookbooks.  The
  # duckpan::default recipe sets up some dependencies and calls the included
  # duckpan.sh shell script.
  config.vm.provision :chef_solo do |chef|
    # chef.cookbooks_path = './cookbooks'
    # chef.add_recipe 'duckpan'
  end

  # setup synced folder for the DDG code: "local host machine path", "path on guest vm"
  # NOTE: If you change the guest VM path from /code edit the find command in duckpan.sh
  config.vm.synced_folder CUSTOM_CONFIG['DDG_PATH'], "/code"
end

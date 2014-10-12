# -*- mode: ruby -*-
# vi: set ft=ruby :

CUSTOM_CONFIG = {
                  "BOX_NAME"  =>  "precise64-current", 
                # This box URL includes the latest bugfix & security patches.
                # It curently ships with VirtualBox guest additions 4.1.12,
                # and the raring HWE stack (kernel 3.8.)
                  "BOX_URL"   =>  "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box",
                  "HEADLESS"  =>  false, 
                  "DDG_PATH"  =>  "~/DuckDuckGo/repos",
				  "PERLBREW_PERL_VERSION" => ["perl-5.16.3"]
                }

Vagrant.configure("2") do |config|

  # The cloud-images.ubuntu.com boxes ship without chef,
  # so we need to install it.
  # If you were using a files.vagrantup.com precise64 box instead,
  # it ships with chef 10, so it needs to be upgraded with this same line.
  config.omnibus.chef_version = :latest

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

  # Enable provisioning with chef solo, using the included cookbooks.  The
  # duckpan::default recipe sets up some dependencies and calls the included
  # duckpan.sh shell script.
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = './cookbooks'
    chef.add_recipe 'apt'
    chef.add_recipe 'build-essential'

    # perlbrew_root defaults to /opt/perlbrew
    chef.json = { "perlbrew" => { "perls" => CUSTOM_CONFIG['PERLBREW_PERL_VERSION'] } }
    chef.add_recipe 'perlbrew'

    chef.add_recipe 'duckpan'

    # uncomment to run chef-solo in debug
    #chef.arguments = '-l debug'
  end

  # setup synced folder for the DDG code: "local host machine path", "path on guest vm"
  config.vm.synced_folder CUSTOM_CONFIG['DDG_PATH'], "/code"
end

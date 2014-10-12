#
# Cookbook Name:: duckpan
# Recipe:: default
#

include_recipe 'git'


execute "chown -R vagrant #{node[:perlbrew][:perlbrew_root]}"
# The perlbrew homepage says to use .bash_profile, but that file does not exist
# and despite what the bash manpage says, it is not sourced on the Ubuntu 12.04.
# So use .bashrc instead.
execute "echo \"source #{node[:perlbrew][:perlbrew_root]}/etc/bashrc\" >> ~vagrant/.bashrc" do
  user "vagrant"
end

execute "echo \"source #{node[:perlbrew][:perlbrew_root]}/etc/bashrc\" >> /etc/skel/.bashrc"
# The attribute ['perlbrew']['install_options'] = "--switch" does not seem to
# work, so we call the switch subcommand manually.
# You do need to source the .bashrc file to run the subswitch command;
# calling the full filepath to perlbrew is not sufficient.
execute "bash -l -i -c \"perlbrew switch #{node[:perlbrew][:perls][0]}\"" do
  environment ({ "HOME" => "/home/vagrant" })
  user "vagrant"
end

# cloud-images.ubuntu.com boxes have linux-headers-generic installed
# (currently linux-headers-3.2.0-61-generic) installed, even though
# the only kernel they have installed is linux-image-generic-lts-raring
# Let's remove those headers to save space. (11.3 MB)
execute "if ! dpkg-query --status linux-image-generic &> /dev/null; then sudo aptitude purge -y linux-headers-generic; fi"

# Without this configuration, if a user resets the MAC address of the network
# card (which is often done by users of VirtualBox), udev will rename eth0 to
# eth1 and users will not have networking until they (boot to recovery mode and)
# manually configure eth1.
#
# Reference: http://askubuntu.com/questions/240632/how-to-disable-udev-net-rule-generation
file "/etc/udev/rules.d/70-persistent-net.rules" do
  action :delete
end
file "/etc/udev/rules.d/75-persistent-net-generator.rules" do
  content "# "
end

# This step is requried with the cloud-images.ubuntu.com boxes
execute "sudo apt-get -y install libssl-dev"

# download the duckpan install script
execute "su -l vagrant -c 'wget -L http://duckpan.com/install.pl -O duckpan-install.pl'"

# run the duckpan script
#   installs App::DuckPAN
execute "duckpan_install_again" do
  # need to run command as user vagrant
  # only by invoking command through bash does .bashrc gets sourced properly
  # .bashrc sets important PERL environment variables from perlbrew for duckpan
  command	"su -l vagrant -c 'bash -l -i -c \"perl duckpan-install.pl\"'"
end

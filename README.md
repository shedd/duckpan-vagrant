[DuckPAN](https://github.com/duckduckgo/p5-app-duckpan) is an application built to provide developers a testing environment for [DuckDuckHack Instant Answers](http://duckduckhack.com). It allows you to test instant answer triggers and preview their visual design and output.

This project provides a Vagrant-based development setup for DuckPAN.

### Installation

1. Install: [Vagrant](http://docs.vagrantup.com/v2/installation/index.html)

2. Clone this repo

3. Install the OS dependencies for vagrant-berkshelf. On Ubuntu, `sudo apt-get install build-essential autoconf`

4. Install the [ChefDK](https://downloads.chef.io/chef-dk/). If the ChefDK is unavailable for your Linux distro, follow the [Workaround for Linux distros not supported by the ChefDK](#workaround-for-linux-distros-not-supported-by-the-chefdk) below.

5. Run `vagrant plugin install vagrant-berkshelf`

6. Run `vagrant plugin install vagrant-omnibus` so that Chef within the box can be upgraded to a version compatible with chef on the host OS.

7. Review the CUSTOM_CONFIG settings at the top of Vagrant file.  You will want to customize the value of the synced directory to point to your local directory containing the DuckDuckGo code you wish to test.  By default, Vagrant will load a [VirtualBox Precise64](http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box) machine image.  If you change this, DuckDuckGo recommends Ubuntu (https://github.com/duckduckgo/p5-app-duckpan#disclaimer).

8. Run `vagrant up`

The box takes some time to stand up.  As the duckpan-install script runs, you won't see any output for a few minutes.  On my 2.7 Ghz i7 Macbook Pro, it takes 18 minutes to complete.  Refer to [Troubleshooting](#Troubleshooting) for more info.

### Workaround for Linux distros not supported by the ChefDK

1. Run `vagrant plugin install vagrant-berkshelf --plugin-version=2.0.1` (command 1), *before* following running `vagrant plugin install berkshelf`(command 2). If you already ran command 2, run command 1 and then command 2. (Note that this results in berkshelf being installed as a vagrant-managed gem. We do not need the entire ChefDK, only berkshelf.)

2. Add `~/.vagrant.d/gems/bin/` to your path. For example, at the bottom of `~/.bashrc`, add:
`export PATH=${PATH}:~/.vagrant.d/gems/bin/`

### Usage

You can find the usage instructions for DuckPAN here: https://github.com/duckduckgo/p5-app-duckpan#using-duckpan

By default, after starting `duckpan server` you can access the web interface at http://0.0.0.0:5000

### Troubleshooting

#### Slow Chef Run

The Chef run may take a while to complete, and during this process, you may see no output from vagrant.

You can ssh into the box and run top to verify installation is still occurring. Look for either the chef-solo or perl processes.

```sh
vagrant ssh
top
```

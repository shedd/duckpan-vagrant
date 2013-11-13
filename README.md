DuckPAN (https://github.com/duckduckgo/p5-app-duckpan) is an application built to provide developers a testing environment for DuckDuckHack Instant Answers (http://duckduckhack.com). It allows you to test instant answer triggers and preview their visual design and output.

This project provides a Vagrant-based development setup for DuckPAN.

### Installation

1. Install Vagrant: http://docs.vagrantup.com/v2/installation/index.html

2. Clone the repo

3. To avoid cluttering `Vagrantfile` with too much configuration, this repo uses Dotenv to load in configuration from environment variables.

Run `bundle install` to install the Dotenv gem.

4. Copy `.env.example` and rename to `.env`  Review and customize the configuration as desired.  

By default, Vagrant will load a VirtualBox Precise64 (http://files.vagrantup.com/precise64.box) machine image.  If you change this, DuckDuckGo recommends Ubuntu (https://github.com/duckduckgo/p5-app-duckpan#disclaimer).

You will also want to customize the value of `DDG_PATH` to point to your local directory containing the DuckDuckGo code you wish to test.

4. Run `vagrant up`

The box takes some time to stand up.

### Usage

You can find the usage instructions for DuckPAN here: https://github.com/duckduckgo/p5-app-duckpan#using-duckpan

### ToDos

* The DuckDuckGo repos have dependencies listed in dist.ini for http://dzil.org yet DuckPAN installation doesn't seem to use this information to ensure dependencies are installed.  Or look at https://github.com/miyagawa/carton (Bundler for Perl)?
* Use Perlbrew like the existing VirtualBox image
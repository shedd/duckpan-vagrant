DuckPAN (https://github.com/duckduckgo/p5-app-duckpan) is an application built to provide developers a testing environment for DuckDuckHack Instant Answers (http://duckduckhack.com). It allows you to test instant answer triggers and preview their visual design and output.

This project provides a Vagrant-based development setup for DuckPAN.

### Installation

1. Install [Vagrant](http://docs.vagrantup.com/v2/installation/index.html)

2. Clone this repo

3. By default, Vagrant will load a [VirtualBox Precise64](http://files.vagrantup.com/precise64.box) machine image.  Note that DuckDuckGo recommends Ubuntu (https://github.com/duckduckgo/p5-app-duckpan#disclaimer).

4. You will also want to customize the value of the synced directory to point to your local directory containing the DuckDuckGo code you wish to test.

5. Run `vagrant up`

The box takes some time to stand up. Refer to [Troubleshooting](#Troubleshooting) for more info.

### Usage

You can find the usage instructions for DuckPAN here: https://github.com/duckduckgo/p5-app-duckpan#using-duckpan

### Troubleshooting

#### Slow Chef Run

The Chef run may take a while to complete, and during this process, you may see no output from vagrant.

You can ssh into the box and run top to verify installation is still occurring. Look for either the chef-solo or perl processes.

```sh
vagrant ssh
top
```

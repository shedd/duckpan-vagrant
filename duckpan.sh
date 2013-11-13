#!/bin/bash
USER_CMD="su -l vagrant -c"
$USER_CMD "wget -L http://duckpan.com/install.pl -O duckpan-install.pl"

# needed to install the below to get duckpan to complete:
sudo apt-get -y install liblocal-lib-perl
sudo apt-get -y install perl-doc

$USER_CMD "perl duckpan-install.pl ; perl -I/home/vagrant/perl5/lib/perl5 -Mlocal::lib duckpan-install.pl"

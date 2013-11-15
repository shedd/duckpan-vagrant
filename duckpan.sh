#!/bin/bash
USER_CMD="su -l vagrant -c"

# needed to install the below to get duckpan to complete:
sudo apt-get -y install liblocal-lib-perl
sudo apt-get -y install perl-doc

# download the duckpan install script
$USER_CMD "wget -L http://duckpan.com/install.pl -O duckpan-install.pl"

# run the duckpan script
$USER_CMD "perl duckpan-install.pl ; perl -I/home/vagrant/perl5/lib/perl5 -Mlocal::lib duckpan-install.pl"

# install perl dependencies for everything in /code
for i in $(find '/code/' -maxdepth 1 -type d)
do
    echo "checking $i for Perl dependencies"
    cd $i
    duckpan installdeps
done
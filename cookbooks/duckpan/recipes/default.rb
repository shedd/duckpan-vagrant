#
# Cookbook Name:: duckpan
# Recipe:: default
#

include_recipe 'perl'
include_recipe 'git'

#bash 'download and install duckpan' do
#   code ::File.open('/vagrant/duckpan.sh').read
#end

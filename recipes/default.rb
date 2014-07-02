#
# Cookbook Name:: dcp
# Recipe:: default
#
# Copyright (C) 2014 Dan Poggi
#
# Licensed under the MIT License, see LICENSE for details.
#

# Install packages we want for administration
include_recipe 'zsh'
include_recipe 'git'
include_recipe 'users::sysadmins'
package 'curl'
package 'vim'
package 'htop'
package 'ack-grep'

# Make sure dotfiles are in order
dcp_script 'remove-dotfiles' do
  user node['dcp']['user']
  check_dcp true
end
dcp_script 'bootstrap' do
  user node['dcp']['user']
  check_dcp true
end

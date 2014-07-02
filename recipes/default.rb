#
# Cookbook Name:: dcp
# Recipe:: default
#
# Copyright (C) 2014 Dan Poggi
#
# Licensed under the MIT License, see LICENSE for details.
#

# Include recipes
include_recipe 'zsh'
include_recipe 'git'
include_recipe 'users::sysadmins'

# Install packages we want for administration
packages = %w(
  curl
  wget
  vim
  unzip
  htop
  ack-grep
  fail2ban
  unattended-upgrades
)
packages.each { |name| package name }

# Configure security updates
file '/etc/apt/apt.conf.d/10periodic' do
  owner 'root'
  group 'root'
  mode '0644'
  content <<-EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
  EOF
end

# Configure NTP
file '/etc/cron.daily/ntpdate' do
  owner 'root'
  group 'root'
  mode '0755'
  content <<-EOF
#!/bin/sh
ntpdate -s ntp.ubuntu.com pool.ntp.org
  EOF
end

# Harden sshd
sed_commands = [
  's/^X11Forwarding yes/X11Forwarding no/g',
  's/^UsePAM yes/UsePAM no/g',
]
bash 'harden-sshd' do
  user 'root'
  code <<-BASH
    #{sed_commands.map { |cmd| "sed -i '#{cmd}' /etc/ssh/sshd_config" }.join("\n")}
  BASH
end
service 'ssh' do
  provider Chef::Provider::Service::Upstart
  supports :restart => true
  action :restart
end

# Make sure dotfiles are in order
dcp_script 'remove-dotfiles' do
  user node['dcp']['user']
  check_dcp true
end
dcp_script 'bootstrap' do
  user node['dcp']['user']
  check_dcp true
end

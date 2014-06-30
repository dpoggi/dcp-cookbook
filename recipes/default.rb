#
# Cookbook Name:: dcp
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'git'
package 'curl' do
  action :install
end

execute "Remove dotfiles for #{node['dcp']['user']} to prep for DCP" do
  command "curl --location --silent \"https://raw.githubusercontent.com/dpoggi/dcp/master/bin/dcp-remove-dotfiles\" | bash"
  cwd "/home/#{node['dcp']['user']}"
  environment({ 'PATH' => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', })
  user node['dcp']['user']
  group node['dcp']['user']
  not_if do
    File.exists?("/home/#{node['dcp']['user']}/.dcp")
  end
end

execute "Install DCP for user #{node['dcp']['user']}" do
  command "curl --location --silent \"https://raw.githubusercontent.com/dpoggi/dcp/master/bin/dcp-bootstrap\" | bash"
  cwd "/home/#{node['dcp']['user']}"
  environment({ 'PATH' => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', })
  user node['dcp']['user']
  group node['dcp']['user']
  not_if do
    File.exists?("/home/#{node['dcp']['user']}/.dcp")
  end
end

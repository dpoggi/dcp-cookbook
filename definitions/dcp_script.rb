#
# Cookbook Name:: dcp
# Definition:: dcp_script
#
# Copyright (C) 2014 Dan Poggi
#
# Licensed under the MIT License, see LICENSE for details.
#

define :dcp_script, :user => nil, :check_dcp => false do
  if params[:user] && File.exists?("/home/#{params[:user]}")
    script_name = params[:name]
    user_name = params[:user]
    check_dcp = params[:check_dcp]

    execute "dcp_script-#{script_name}-#{user_name}" do
      command "curl --location --silent \"https://raw.githubusercontent.com/dpoggi/dcp/master/bin/dcp-#{script_name}\" | bash"
      cwd "/home/#{user_name}"
      environment({ 'PATH' => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', })
      user user_name
      group user_name

      if check_dcp
        not_if { File.exists?("/home/#{user_name}/.dcp") }
      end
    end
  end
end

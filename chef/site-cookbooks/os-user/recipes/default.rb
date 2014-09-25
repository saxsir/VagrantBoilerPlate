#
# Cookbook Name:: os-user
# Recipe:: default
#
users = node['os_user']['users']
users.each do |username|
  user username do
    home "/home/#{username}"
    shell "/bin/zsh"
    password nil
    supports :manage_home => true
    action [:create, :manage]
  end

  directory "/home/#{username}" do
    owner "#{username}"
    group "developer"
    mode "0755"
    action :create
  end

  directory "/home/#{username}/.ssh" do
    owner "#{username}"
    group "#{username}"
    mode "0700"
    action :create
  end
end

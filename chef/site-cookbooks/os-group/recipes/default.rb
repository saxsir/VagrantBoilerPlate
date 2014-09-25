#
# Cookbook Name:: os-group
# Recipe:: default
#
users = node['os_user']['users']
group "developer" do
  members users
  action :create
end

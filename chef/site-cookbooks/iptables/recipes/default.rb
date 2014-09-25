#
# Cookbook Name:: iptables
# Recipe:: default
#
package "iptables" do
  action :install
end

service "iptables" do
  action [:enable]
end

template "/etc/sysconfig/iptables" do
  owner "root"
  group "root"
  mode 0600
  notifies :restart, "service[iptables]"
end

#
# Cookbook Name:: mysql
# Recipe:: default
#

%w{mysql mysql-server}.each do |pkg|
  package pkg do
    action :install
    options "--enablerepo=mysql56-community"
  end
end

service "mysqld" do
 action [:enable, :start]
end

bash "set_root_password" do
  user "root"
  code <<-EOC
    mysqladmin -u root password "#{node['mysql']['root_password']}"
  EOC
  only_if "mysql -u root -e 'show databases;'"
end

bash "backup_my.cnf" do
  user "root"
  code <<-EOC
    cp /etc/my.cnf /etc/my.cnf.bak
  EOC
  # すでに存在したら上書きしない
  creates "/etc/my.cnf.bak"
end

template "/etc/my.cnf" do
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[mysqld]"
end

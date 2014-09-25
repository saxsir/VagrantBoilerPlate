#
# Cookbook Name:: httpd
# Recipe:: default
#
# httpdをインストールするレシピ
#

package "httpd" do
  action :install
end

service "httpd" do
  action [:enable, :start]
end

bash "backup_httpd.conf" do
  user "root"
  code <<-EOC
    cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
  EOC
  # すでに存在したら上書きしない
  creates "/etc/httpd/conf/httpd.conf.bak"
end

bash "delete_welcome.conf" do
  user "root"
  code <<-EOC
    rm -f /etc/httpd/conf.d/welcome.conf
  EOC
end

template "/etc/httpd/conf/httpd.conf" do
  owner "root"
  group "root"
  mode 0644
  variables({
    :document_root => "#{node['httpd']['document_root']}",
    :server_name => "#{node['httpd']['server_name']}"
  })

  notifies :reload, "service[httpd]"
end

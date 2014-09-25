#
# Cookbook Name:: localtime
# Recipe:: default
#
bash 'change_localtime' do
  user 'root'
  code <<-EOC
    cp -p /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
  EOC
  notifies :restart, "service[httpd]"
end



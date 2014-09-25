#
# Cookbook Name:: php
# Recipe:: default
#

#TODO: 開発に必要なモジュールを調べて追加する（php-pdoとか）
%w{php php-pdo php-mysqlnd}.each do |pkg|
  package pkg do
    action :install
    options "--enablerepo=remi-php56"
  end
end

bash "backup_php.ini" do
  user "root"
  code <<-EOC
    cp /etc/php.ini /etc/php.ini.bak 
  EOC
  # すでに存在したら上書きしない
  creates "/etc/php.ini.bak"
end

template "/etc/php.ini" do
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[httpd]"
end

template "/var/www/html/phpinfo.php" do
  owner "root"
  group "root"
  mode 0644
end

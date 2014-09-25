#
# Cookbook Name:: base
# Recipe:: default
#
# デフォルトで入れておきたいパッケージ郡
#
%w{git vim zsh dstat tree unzip cronie-noanacron}.each do |pkg|
  package pkg do
    action :install
  end
end

%w{siege npm}.each do |pkg|
  package pkg do
    action :install
    options "--enablerepo=epel"
  end
end

bash "remove_cronie-anacron" do
  user "root"
  code <<-EOC
    yum remove cronie-anacron -y
  EOC
end

template "/etc/cron.d/dailyjobs" do
   owner "root"
   group "root"
   mode 0755
end

service "crond" do
  action [:enable, :start]
end

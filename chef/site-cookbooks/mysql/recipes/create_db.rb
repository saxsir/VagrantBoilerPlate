#
# Cookbook Name:: mysql
# Recipe:: create_db
#

# データベース作成
db_name =  "#{node['mysql']['db_name']}"
template "#{Chef::Config[:file_cache_path]}/create_db.sql" do
  owner 'root'
  group 'root'
  mode 0644
  variables({
    :db_name => db_name,
  })
end

bash 'create_db' do
  user 'root'
  code <<-EOC
    mysql -u root --password="#{node['mysql']['root_password']}" < #{Chef::Config[:file_cache_path]}/create_db.sql
  EOC
  not_if "mysql -u root --password=\"#{node['mysql']['root_password']}\" -D #{db_name}"
end

# DBユーザー作成
user_name = "#{node['mysql']['db_user']}"

user_password = "#{node['mysql']['db_user_pass']}"

template "#{Chef::Config[:file_cache_path]}/create_user.sql" do
  owner 'root'
  group 'root'
  mode 0644
  variables({
    :db_name => db_name,
    :username => user_name,
    :password => user_password,
  })
end

bash 'create_db_user' do
  user 'root'
  code <<-EOC
    mysql -u root --password="#{node['mysql']['root_password']}" < #{Chef::Config[:file_cache_path]}/create_user.sql
  EOC
  not_if "mysql -u #{user_name} -p#{user_password} -D #{db_name}"
end

#
# Cookbook Name:: yum-repo
# Recipe:: default
#
# yumのリポジトリを追加する
# http://d.hatena.ne.jp/yk5656/20140410/1397390498

bash 'add_epel' do
  user 'root'
  code <<-EOC
    rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    sed -i -e "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/epel.repo
  EOC
  creates "/etc/yum.repos.d/epel.repo"
end


bash 'add_rpmforge' do
  user 'root'
  code <<-EOC
    rpm -ivh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
    sed -i -e "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/rpmforge.repo
  EOC
  creates "/etc/yum.repos.d/rpmforge.repo"
end

bash 'add_remi' do
  user 'root'
  code <<-EOC
    rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
    sed -i -e "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/remi.repo
  EOC
  creates "/etc/yum.repos.d/remi.repo"
end

bash 'add_mysql_community' do
  user 'root'
  code <<-EOC
    rpm -ivh http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm 
    sed -i -e "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/mysql-community.repo
  EOC
  creates "/etc/yum.repos.d/mysql-communityrepo"
end

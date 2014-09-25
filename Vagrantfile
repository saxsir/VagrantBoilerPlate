# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
SERVER_NAME = 'metamon' #好きなサーバー名に変更する

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # https://vagrantcloud.com/chef/boxes/centos-6.5
  config.vm.box = "chef/centos-6.5"
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.hostname = SERVER_NAME

  config.vm.provider "virtualbox" do |vb|
    vb.name = SERVER_NAME
    vb.memory = 512
  end

  config.omnibus.chef_version = :latest

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = ["./chef/cookbooks", "./chef/site-cookbooks"]
    chef.roles_path = "./chef/roles"
    chef.data_bags_path = "./chef/data_bags"

    chef.add_recipe "yum-repo"
    chef.add_recipe "base"
    chef.add_recipe "localtime"
    chef.add_recipe "iptables"
    chef.add_recipe "httpd"
    chef.add_recipe "php"
    chef.add_recipe "mysql"
    chef.add_recipe "mysql::create_db"
    chef.add_recipe "os-user"
    chef.add_recipe "os-group"
    chef.add_recipe "sl" #ネタ

    #TODO: 外部ファイルで指定して、git管理から外す
    # まぁでもVMの設定だし見えてもいいような気もする
    chef.json = {
      os_user: {
        users: ['saxsir'] #作業用ユーザー
      },
      httpd: {
        server_name: SERVER_NAME,
        document_root: '/var/www/html'
      },
      mysql: {
        root_password: "rootpass",
        db_name: SERVER_NAME,
        db_user: "#{SERVER_NAME}-user",
        db_user_pass: "#{SERVER_NAME}pass"
      }
    }
  end
end

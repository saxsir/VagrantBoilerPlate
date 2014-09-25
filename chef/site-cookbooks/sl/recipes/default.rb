#
# Cookbook Name:: sl
# Recipe:: default
#
# slコマンドをインストールする
# デフォルトのyumだと入っていないので、epelを有効にしてインストールする

package "sl" do
  action :install
  options "--enablerepo=epel"
end

require 'spec_helper'

# mysql-communityのリポジトリからインストールしたらなんかうまく判定されない...
#%w{mysql, mysql-server}.each do |pkg|
#  describe package(pkg) do
#    it { should be_installed }
#  end
#end

describe command("mysql --version | awk -F ' ' '{print $5}'") do
  it { should return_stdout /5\.6/}
end

describe service('mysqld') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(3306) do
  it { should be_listening }
end

describe file('/etc/my.cnf') do
  it { should be_file }
  # TODO: mysqlの設定のテストはあとで書く
end

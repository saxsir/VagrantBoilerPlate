require 'spec_helper'

describe package('iptables') do
  it { should be_installed }
end

describe service('iptables') do
  it { should be_enabled   }
  it { should be_running   }
end

describe file('/etc/sysconfig/iptables') do
  it { should be_file }

  # 外からの通信はすべて受け付けない
  its(:content) { should match /^\:INPUT DROP \[0\:0\]/ }
  its(:content) { should match /^\:FORWARD DROP \[0\:0\]/ }
  its(:content) { should match /^\:OUTPUT ACCEPT \[0\:0\]/ }

  # 確率済みの通信なら通す
  its(:content) { should match /-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT/ }

  # pingは通してやる
  its(:content) { should match /^-A INPUT -p icmp -j ACCEPT/ }

  # 自ホストからの通信は問答無用で全部通してやる
  its(:content) { should match /^-A INPUT -i lo -j ACCEPT/ }

  # SSHは通してやる
  its(:content) { should match /^-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT/ }

  # http, mysqlも通す
  its(:content) { should match /^-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT/ }
  its(:content) { should match /^-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT/ }
end

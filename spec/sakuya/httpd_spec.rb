require 'spec_helper'

describe package('httpd') do
  it { should be_installed }
  it { should be_installed.with_version('httpd-2.2') }
end

describe service('httpd') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(80) do
  it { should be_listening }
end

describe file('/etc/httpd/conf/httpd.conf') do
  it { should be_file }
  its(:content) { should match /ServerName metamon/ }

  # サーバの出力情報の制限
  its(:content) { should match /^\s*ServerSignature Off/ }
  its(:content) { should match /^\s*ServerTokens Prod/ }

  # Optionsの制限
  its(:content) { should match /<Directory \/>.*Options -Indexes -FollowSymLinks.*<\/Directory>$/m }

  # Cross Site Tracking攻撃への対応
  its(:content) { should match /^\s*TraceEnable Off/ }

  # CGIの無効化
  its(:content) { should_not match /^\s*ScriptAlias \/cgi-bin\/ \"\/var\/www\/cgi-bin\/\"/ }
  its(:content) { should_not match /^\s*<Directory \"\/var\/www\/cgi-bin\">/m }

  # 不要なエイリアスの無効化
  its(:content) { should_not match /^\s*Alias \/icons\/ \"\/var\/www\/icons\/\"/ }
end

# welcome.confの削除
describe file('/etc/httpd/conf.d/welcome.conf') do
  it { should_not be_file }
end

require 'spec_helper'

%w{git zsh dstat tree unzip cronie-noanacron siege npm}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe service('crond') do
  it { should be_enabled   }
  it { should be_running   }
end

describe command('which vim') do
  it { should return_stdout '/usr/bin/vim' }
end

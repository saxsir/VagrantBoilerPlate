require 'rake'
require 'rspec/core/rake_task'

# 複数サーバー同時にテストする場合はこちらを参照
# http://ex-cloud.jp/techblog/?p=699
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end

task :default => :spec

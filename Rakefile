require "rake/testtask"
require "./reversi"

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

desc "execute reversi game"
task :run do |t|
  Reversi.new.show
end
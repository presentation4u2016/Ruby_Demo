require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'


############# ALL ###########

desc "Run all tests"
# RUN ALL
RSpec::Core::RakeTask.new('all') do |t|
  t.rspec_opts = ["--format documentation","--color"]
  t.pattern = [
  	'LivingSocial/*.rb'
  ]
end 

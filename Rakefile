require 'rspec/core/rake_task'

name = File.basename(Dir.getwd)

file "lib/#{name}/#{name}.so" => Dir["ext/#{name}/*{.rb,.c}"] do
  Dir.chdir("ext/#{name}") do
    ruby 'extconf.rb'
    sh 'make'
  end
  file_extension = RbConfig::CONFIG['DLEXT']
  cp "ext/#{name}/#{name}.#{file_extension}", "lib/#{name}"
end

RSpec::Core::RakeTask.new(:spec)
task :spec => "lib/#{name}/#{name}.so"
task :default => :spec

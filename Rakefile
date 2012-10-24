require 'rspec/core/rake_task'

gem_name   = File.basename(Dir.getwd)
ext_dir    = "ext/#{gem_name}"
ext_type   = RbConfig::CONFIG['DLEXT']
dependency = "#{ext_dir}/#{gem_name}.#{ext_type}"

task :make =>
Dir.glob("#{ext_dir}/*{.rb,.c}") do
  Dir.chdir(ext_dir) do
    ruby "extconf.rb"
    sh "make"
  end
cp dependency, "lib/#{gem_name}/"
end

RSpec::Core::RakeTask.new(:spec)
task :spec => :make
task :default => :spec

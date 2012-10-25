require 'rspec/core/rake_task'

gem_name   = File.basename(Dir.getwd)
ext_dir    = "ext/#{gem_name}"
ext_type   = RbConfig::CONFIG['DLEXT']
dependency = "#{ext_dir}/#{gem_name}.#{ext_type}"

desc 'Compile the C-extension that this gem depends upon'
task :compile do
  Dir.glob("#{ext_dir}/*{.rb,.c}") do
    Dir.chdir(ext_dir) do
      ruby "extconf.rb"
      sh "make"
    end
  cp dependency, "lib/#{gem_name}/"
  end
end

desc "Run this if you've changed Ruby versions"
task :clean do
  %W(Makefile #{gem_name}.#{ext_type} #{gem_name}.o).each do |f|
    rm_f "#{ext_dir}/#{f}"
  end
  rm_f "lib/#{gem_name}/#{gem_name}.#{ext_type}"
end

desc 'Benchmark the worker against your machine'
task :benchmark => :compile do
  require 'haystack_worker'
  HaystackWorker.benchmark
end

RSpec::Core::RakeTask.new(:spec)
task :spec => :compile
task :default => :spec

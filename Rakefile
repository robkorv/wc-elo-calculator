require 'rubygems'

task :default => [:test, :features]

task :test do
    puts "Running cucumber"
end

begin
    require 'cucumber'
    require 'cucumber/rake/task'

    Cucumber::Rake::Task.new(:features) do |t|
        t.cucumber_opts = "--format pretty"
    end

rescue LoadError
    desc 'Cucumber rake task not available'
    task :features do
        abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
    end
end

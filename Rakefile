require 'rubygems'

task :default => [:test,  :rubocop, :features]

task :test do
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


require 'rubocop/rake_task'
RuboCop::RakeTask.new

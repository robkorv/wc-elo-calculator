require 'rubygems'

task default: [:clean, :rubocop, :cucumber]

task :clean do
  puts 'Cleaning....'
  html_file = 'eloratings.html'
  File.delete(html_file) if File.file?(html_file)
end

begin
  require 'cucumber'
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new

rescue LoadError
  desc 'Cucumber rake task not available'
  task :cucumber do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as
    a gem or plugin'
  end
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new

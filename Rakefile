require 'puppet-lint/tasks/puppet-lint'
require 'rubocop/rake_task'

Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |task|
  task.ignore_paths = ["spec/**/*.pp", "pkg/**/*.pp"]
  task.with_context = true
  task.with_filename = true
end

namespace :syntax do
  desc "Test (erb/ruby) syntax on all files in templates/*"
  task :templates do
    files = FileList["templates/**/*.*"]
    files.each do |template|
      sh "erb -P -x -T '-' #{template} | ruby -c"
    end
  end
  desc "Run puppet syntax validation on all manifests"
  task :manifests do
    files = FileList["manifests/**/*.pp"]
    files.each do |pp|
      sh "puppet parser validate --noop #{pp}"
    end
  end
end
desc "Run all syntax checks"
task :syntax => ['syntax:manifests', 'syntax:templates']

namespace :jenkins do
  PuppetLint::RakeTask.new :lint do |task|
    task.ignore_paths = ["spec/**/*.pp", "pkg/**/*.pp"]
    task.fix = false
    task.log_format = '%{path}:%{linenumber}:%{check}:%{KIND}:%{message}'
  end
  desc "Outputs a style report to rubocop/checkstyle.xml"
  RuboCop::RakeTask.new(:rubocop) do |task|
    mkdir_p 'rubocop'
    task.patterns = ['Rakefile', "lib/**/*.rb"]
    task.formatters = ['fu']
    task.fail_on_error = true
    task.requires = ['rubocop/formatter/checkstyle_formatter']
    task.options = [
      '--format', 'RuboCop::Formatter::CheckstyleFormatter',
      '-o', 'rubocop/checkstyle.xml',
      '--fail-level', 'E'
    ]
  end
end

task :jenkins => ['syntax', 'jenkins:lint', 'jenkins:rubocop' ]
task :default => ['syntax', 'jenkins' ]

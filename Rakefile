#!/usr/bin/env rake
# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'
require_relative 'test/integration/configuration/aws_inspec_config'

# Rubocop
desc 'Run Rubocop lint checks'
task :rubocop do
  RuboCop::RakeTask.new
end

# Minitest
Rake::TestTask.new do |t|
  t.libs << 'libraries'
  t.libs << File.join('test','unit')
  t.warning = false
  t.verbose = true
  t.pattern = File.join('test','unit','**','*_test.rb')
end

# lint the project
desc 'Run robocop linter'
task lint: [:rubocop]

# run tests
task default: [:lint, :test, 'test:check']

namespace :test do
  # Specify the directory for the integration tests
  integration_dir = File.join('test','integration')

  # Specify the terraform plan name
  plan_name = 'inspec-aws.plan'

  # Specify the file_name for terraform variables to be stored
  variable_file_name = 'inspec-aws.tfvars'

  # The below file allows to inject parameters as profile attributes to inspec
  profile_attributes = 'aws-inspec-attributes.yaml'

  # run inspec check to verify that the profile is properly configured
  task :check do
    dir = File.join(File.dirname(__FILE__))
    sh("bundle exec inspec check #{dir}")
    # run inspec check on the sample profile to ensure all resources are loaded okay
    # Disabling inspec check on profile with path dependency due to https://github.com/inspec/inspec/issues/3571
    # sh("cd #{integration_dir}/verify && bundle exec inspec check .")
  end

  task :init_workspace do
    # Initialize terraform workspace
    cmd = format('cd %s && terraform init', File.join(integration_dir,'build'))
    sh(cmd)
  end

  task :plan_integration_tests do
    puts '----> Generating terraform and InSpec variable files'
    AWSInspecConfig.store_json(variable_file_name)
    AWSInspecConfig.store_yaml(profile_attributes)
    puts '----> Generating the plan'
    # Create the plan that can be applied to AWS
    cmd = format('cd %s && terraform plan  -var-file=%s -out %s', File.join(integration_dir,'build'), variable_file_name, plan_name)
    sh(cmd)
  end

  task :setup_integration_tests do
    puts '----> Applying the plan'
    # Apply the plan on AWS
    cmd = format('cd %s && terraform apply %s', File.join(integration_dir,'build'), plan_name)
    sh(cmd)
    puts '----> Adding terraform outputs to InSpec variable file'
    AWSInspecConfig.update_yaml(profile_attributes)
  end

  task :run_integration_tests do
    puts '----> Running InSpec tests'
    target = if ENV['INSPEC_PROFILE_TARGET'] then ENV['INSPEC_PROFILE_TARGET'] else File.join(integration_dir,'verify') end
    reporter_name = if ENV['INSPEC_REPORT_NAME'] then ENV['INSPEC_REPORT_NAME'] else 'inspec-output' end
    # Since the default behaviour is to skip tests, the below absorbs an inspec "101 run okay + skipped only" exit code as successful
    cmd = 'bundle exec inspec exec %s --attrs %s --reporter cli json:%s.json html:%s.html'
    if ENV['INSPEC_TRAP_NON_ZERO_EXIT'] then cmd += ' || true' else  cmd += '; rc=$?; if [ $rc -eq 0 ] || [ $rc -eq 101 ]; then exit 0; else exit 1; fi' end
    cmd = format(cmd, target, File.join(integration_dir,'build', profile_attributes), reporter_name, reporter_name)
    sh(cmd)
  end

  task :cleanup_integration_tests do
    puts '----> Cleanup'
    cmd = format('cd %s && terraform destroy -force -var-file=%s || true', File.join(integration_dir,'build'), variable_file_name)
    sh(cmd)
  end

  desc 'Perform Integration Tests'
  task :integration do
    Rake::Task['test:init_workspace'].execute
    if File.exist?(File.join(integration_dir, 'build', variable_file_name))
      Rake::Task['test:cleanup_integration_tests'].execute
    end
    Rake::Task['test:plan_integration_tests'].execute
    Rake::Task['test:setup_integration_tests'].execute
    Rake::Task['test:run_integration_tests'].execute
    Rake::Task['test:cleanup_integration_tests'].execute
  end
end

# Automatically generate a changelog for this project. Only loaded if
# the necessary gem is installed.
# use `rake changelog to=1.2.0`
begin
  v = ENV['to']
  require 'github_changelog_generator/task'
  GitHubChangelogGenerator::RakeTask.new :changelog do |config|
    config.future_release = v
  end
rescue LoadError
  puts '>>>>> GitHub Changelog Generator not loaded, omitting tasks'
end

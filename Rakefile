#!/usr/bin/env rake

require 'rake/testtask'
require 'rubocop/rake_task'
require "chefstyle"
require_relative 'test/integration/configuration/aws_inspec_config'

INTEGRATION_DIR = File.join('test', 'integration')
CONTROLS_DIR = File.join(INTEGRATION_DIR, 'verify')
TERRAFORM_DIR = File.join(INTEGRATION_DIR, 'build')
TF_VAR_FILE_NAME = 'inspec-aws.tfvars.json'
TF_VAR_FILE = File.join(TERRAFORM_DIR, TF_VAR_FILE_NAME)
TF_PLAN_FILE = 'inspec-aws.plan'
PROFILE_ATTRIBUTES = 'aws-inspec-attributes.yaml'

# Rubocop
# desc 'Run Rubocop lint checks'
# task :rubocop do
#   RuboCop::RakeTask.new
# end

# Minitest
Rake::TestTask.new do |t|
  t.libs << 'libraries'
  t.libs << File.join('test', 'unit')
  t.warning = false
  t.verbose = true
  t.pattern = File.join('test', 'unit', '**', '*_test.rb')
end

# desc 'Run rubocop linter'
# task lint: [:rubocop]

# lint the project
# chefstyle
begin
  RuboCop::RakeTask.new(:lint) do |task|
    task.options += ["--display-cop-names", "--no-color", "--parallel"]
  end
rescue LoadError
  puts "rubocop is not available. Install the rubocop gem to run the lint tests."
end

# run tests
# Disabling inspec check on profile with path dependency due to https://github.com/inspec/inspec/issues/3571 - 'test:check'
desc 'Run rubocop chefstyle linter + unit tests'
task default: [:lint, :test ]

namespace :test do

  task :check do
    # Run inspec check to verify that the profile is properly configured
    dir = File.join(File.dirname(__FILE__))
    sh("bundle exec inspec check #{CONTROLS_DIR}")
  end

  task :setup_integration_tests => ['tf:setup_integration_tests']

  task :plan_integration_tests => ['tf:plan_integration_tests']

  task :run_integration_tests do
    puts '----> Running InSpec tests'
    target = if ENV['INSPEC_PROFILE_TARGET'] then ENV['INSPEC_PROFILE_TARGET'] else CONTROLS_DIR end
    reporter_name = if ENV['INSPEC_REPORT_NAME'] then ENV['INSPEC_REPORT_NAME'] else 'inspec-output' end
    # Since the default behaviour is to skip tests, the below absorbs an inspec "101 run okay + skipped only" exit code as successful
    cmd = 'bundle exec inspec exec %s -t aws:// --input-file %s --reporter cli json:%s.json html:%s.html --chef-license=accept-silent'
    if ENV['INSPEC_TRAP_NON_ZERO_EXIT'] then cmd += ' || true' else cmd += '; rc=$?; if [ $rc -eq 0 ] || [ $rc -eq 101 ]; then exit 0; else exit 1; fi' end
    cmd = format(cmd, target, File.join(TERRAFORM_DIR.to_s, PROFILE_ATTRIBUTES), reporter_name, reporter_name)
    sh(cmd)
  end

  task :cleanup_integration_tests => ['tf:cleanup_integration_tests']

  desc 'Perform Integration Tests'
  task integration: ['tf:setup_integration_tests'] do
    Rake::Task['test:run_integration_tests'].execute
    Rake::Task['tf:destroy'].execute
  end
end

namespace :tf do

  task :tf_dir do
    Dir.chdir(TERRAFORM_DIR)
  end

  task init_workspace: [:tf_dir] do
    puts '----> Initializing Terraform'
    # Initialize terraform workspace
    cmd = format('terraform init')
    sh(cmd)
  end

  task plan_integration_tests: [:tf_dir, :init_workspace] do
    if File.exist?(TF_VAR_FILE)
      puts '----> Previous run not cleaned up - running cleanup...'
      Rake::Task['tf:cleanup_integration_tests'].execute
    end
    puts '----> Generating Terraform and InSpec variable files'
    AWSInspecConfig.store_json(TF_VAR_FILE_NAME)
    AWSInspecConfig.store_yaml(PROFILE_ATTRIBUTES)
    puts '----> Generating the Plan'
    # Create the plan that can be applied to AWS
    cmd = format('terraform plan -var-file=%s -out %s', TF_VAR_FILE_NAME, TF_PLAN_FILE)
    sh(cmd)
  end

  task setup_integration_tests: [:tf_dir] do
    unless File.exist?(TF_PLAN_FILE)
      Rake::Task['test:plan_integration_tests'].invoke
    end
    puts '----> Applying the plan'
    # Apply the plan on AWS
    cmd = format('terraform apply %s', TF_PLAN_FILE)
    sh(cmd)
    puts '----> Adding terraform outputs to InSpec variable file'
    AWSInspecConfig.update_yaml(PROFILE_ATTRIBUTES)
  end

  task cleanup_integration_tests: [:tf_dir] do
    puts '----> Cleanup'
    cmd = 'terraform destroy -force -var-file=%s '
    cmd += ' || true' if ENV['CLEANUP_TRAP_NON_ZERO_EXIT']
    cmd = format(cmd, TF_VAR_FILE_NAME)
    sh(cmd)
  end
end

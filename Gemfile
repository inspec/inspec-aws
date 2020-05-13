# frozen_string_literal: true

source 'https://rubygems.org'

gem 'bundle'
# Note that 'aws-sdk' pulls in a large number of libraries, choose explicitly those to include instead
# gem 'aws-sdk', '~> 3'
#
# See service list here: https://docs.aws.amazon.com/sdk-for-ruby/v3/api/index.html
#
# See train-aws for a list of dependencies already available: https://github.com/inspec/train-aws/blob/master/train-aws.gemspec
# Note if the gem required is commented out, please raise a PR against the train-aws repo first
# In the mean time the gem can be added here for local development

# Use Latest Inspec
gem 'inspec-bin'

gem 'rubocop', require: false

group :development do
  gem 'rake'
  gem 'minitest'
  gem 'pry-byebug'
end

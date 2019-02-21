# frozen_string_literal: true

source 'https://rubygems.org'

gem 'bundle'
# Note that 'aws-sdk' pulls in a large number of libraries, choose explicitly those to include instead
# gem 'aws-sdk', '~> 3'
# See service list here: https://docs.aws.amazon.com/sdk-for-ruby/v3/api/index.html
gem 'aws-sdk-cloudtrail', '~> 1'
gem 'aws-sdk-cloudwatch', '~> 1'
gem 'aws-sdk-cloudwatchlogs', '~> 1'
gem 'aws-sdk-configservice', '~> 1'
gem 'aws-sdk-ec2', '~> 1'
gem 'aws-sdk-eks', '~> 1'
gem 'aws-sdk-elasticloadbalancing', '~> 1'
gem 'aws-sdk-iam', '~> 1'
gem 'aws-sdk-organizations', '~> 1'
gem 'aws-sdk-rds', '~> 1'
gem 'aws-sdk-s3', '~> 1'
gem 'aws-sdk-sns', '~> 1'
gem 'aws-sdk-sqs', '~> 1'

gem 'rubocop', '~> 0.64.0', require: false

group :development do
  gem 'github_changelog_generator'
  gem 'passgen'
  gem 'rake'
  gem 'minitest'
end

# To uncomment when backwards incompatible releases of InSpec / Train are available.
#group :inspec do
#  gem 'inspec', '~> 3.0', '>= 3.0.25'
#end

# Below required to overcome AWS SDK v2/3 incompatibility
gem 'train', :git => 'https://github.com/inspec/train.git', :branch => 'sp/update-aws-sdk-3'
gem 'inspec', :git => 'https://github.com/inspec/inspec.git', :branch => 'sp/remove-aws-resources'

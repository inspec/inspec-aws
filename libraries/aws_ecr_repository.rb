# frozen_string_literal: true

require 'aws_backend'

class AwsEcrRepository < AwsResourceBase
  name 'aws_ecr_repository'
  desc 'Verifies settings for an AWS ECR Repository'

  example "
    describe aws_ecr_repository('my-repository') do
      it { should exist }
    end
  "
  # describe_images API, constraints
  # https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_DescribeRepositories.html

  def initialize(opts = {})
    # Create a repository_name:<value> pair if the argument is a string object.
    opts = { repository_name: opts } if opts.is_a?(String)
    # Ignore arguments if they are not hash type at this point.
    opts = {} unless opts.is_a?(Hash)

    # Validate the pattern of the identifier.
    raise ArgumentError, "#{}"
  end
end
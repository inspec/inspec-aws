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

  def initialize(opts = {})
    # Create a repository_name:<value> pair if the argument is a string object.
    opts = { repository_name: opts } if opts.is_a?(String)
    # Ignore arguments if they are not hash type at this point.
    opts = {} unless opts.is_a?(Hash)

    # Validation of the repository_name value will be done by AWS service.
    # https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_DescribeRepositories.html

    super(opts)
    validate_parameters(required: %i(repository_name))
    @display_name = opts[:repository_name]

    catch_aws_errors do
      resp = @aws.ecr_client.describe_repositories(repository_names: [opts[:repository_name]])
      @ecr_repo = resp.repositories.first.to_h
      create_resource_methods(@ecr_repo)
    end
  end

  def exists?
    !@ecr_repo.nil?
  end

  def to_s
    "ECR Repository #{@display_name}"
  end
end

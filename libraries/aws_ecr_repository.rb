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

    super(opts)
    validate_parameters(required: %i(repository_name))

    # Validate repository_name.
    pattern = %r{(?:[a-z0-9]+(?:[._-][a-z0-9]+)*/)*[a-z0-9]+(?:[._\-][a-z0-9]+)*}
    matched_str = opts[:repository_name].match(pattern)
    unless (opts[:repository_name] == matched_str[0]) && (matched_str.length == 1) && opts[:repository_name].length.between?(2, 256)
      raise ArgumentError, "#{@__resource_name__}: `repository_name` is not in a valid format. " \
                           'Please check the docs for more info '\
                           'https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_DescribeRepositories.html' \
    end

    @display_name = opts[:repository_name]

    catch_aws_errors do
      resp = @aws.ecr_client.describe_repositories(repository_names: [opts[:repository_name]])
      @ecr_repo = resp.repositories.first.to_h
      create_resource_methods(@ecr_repo)
    end
  end

  def exists?
    !@ecr_repo.nil? && !@ecr_repo.empty?
  end

  def to_s
    "ECR Repository #{@display_name}"
  end

  def tags
    return unless exists?
    catch_aws_errors do
      @resp_tags = @aws.ecr_client.list_tags_for_resource(resource_arn: @ecr_repo[:repository_arn])
    end
    map_tags(@resp_tags.tags)
  end
end

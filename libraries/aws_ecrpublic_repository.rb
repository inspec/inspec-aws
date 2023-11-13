require "aws_backend"

class AwsEcrPublicRepository < AwsResourceBase
  name "aws_ecrpublic_repository"
  desc "Verifies settings for an AWS ECR Public Repository."

  example "
    describe aws_ecrpublic_repository('my-public-repository') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    # Create a repository_name:<value> pair if the argument is a string object.
    opts = { repository_name: opts } if opts.is_a?(String)
    # Ignore arguments if they are not hash type at this point.
    opts = {} unless opts.is_a?(Hash)

    super(opts)
    validate_parameters(required: %i(repository_name), allow: %i(registry_id))

    # Validate repository_name.
    pattern = %r{(?:[a-z0-9]+(?:[._-][a-z0-9]+)*/)*[a-z0-9]+(?:[._\-][a-z0-9]+)*}
    matched_str = opts[:repository_name].match(pattern)
    unless (opts[:repository_name] == matched_str[0]) && (matched_str.length == 1) && opts[:repository_name].length.between?(2, 256)
      raise ArgumentError, "#{@__resource_name__}: `repository_name` is not in a valid format. " \
                           "Please check the docs for more info "\
                           "https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_DescribeRepositories.html" \
    end
    @display_name = opts[:repository_name]

    query_params = {}
    query_params[:repository_names] = [opts[:repository_name]]
    # Validate registry_id. (Optional. If not provided, AWS account ID will be used by the AWS API.)
    if opts.key?(:registry_id)
      raise ArgumentError, "#{@__resource_name__}: `registry_id` should be a string of 12 digits." unless /^[0-9]{12}$/.match?(opts[:registry_id])
      query_params[:registry_id] = opts[:registry_id]
    end

    catch_aws_errors do
      resp = @aws.ecrpublic_client.describe_repositories(query_params)
      @ecr_repo = resp.repositories.first.to_h
      create_resource_methods(@ecr_repo)
    end
  end

  def resource_id
    return @display_name unless exists?
    @ecr_repo[:repository_arn]
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
      @resp_tags = @aws.ecrpublic_client.list_tags_for_resource(resource_arn: @ecr_repo[:repository_arn])
    end
    map_tags(@resp_tags.tags)
  end
end

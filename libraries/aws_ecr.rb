require "aws_backend"

class AwsEcr < AwsResourceBase
  name "aws_ecr"
  desc "Verifies settings for an Elastic Container Registry."

  example "
    describe aws_ecr('container-registry') do
      it { should exist }
    end
  "

  attr_reader :repository_name, :repository_arn, :registry_id, :repository_uri, :created_at, :image_tags, :image_digest, :image_size_in_bytes, :image_pushed_at, :image_uploaded_date

  def initialize(opts = {})
    opts = { repository_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:repository_name])
    Inspec::Log.warn "#{@__resource_name__} has been DEPRECATED. Please use `aws_ecr_repository`, `aws_ecr_repositories`, `aws_ecr_image` or `aws_ecr_images` instead." \

    catch_aws_errors do
      resp = @aws.ecr_client.describe_repositories(repository_names: [opts[:repository_name]])
      return if resp.repositories.nil? || resp.repositories.empty?
      repository = resp.repositories.first
      @repository_name = repository.repository_name
      @repository_arn  = repository.repository_arn
      @registry_id     = repository.registry_id
      @repository_uri  = repository.repository_uri
      @created_at      = repository.created_at.to_s
    end
  end

  def images
    return if !exists?
    resp = nil
    catch_aws_errors do
      resp = @aws.ecr_client.describe_images(repository_name: @repository_name).image_details.first
      @image_tags          = resp.image_tags
      @image_digest        = resp.image_digest
      @image_size_in_bytes = resp.image_size_in_bytes
      @image_pushed_at     = resp.image_pushed_at.to_s
      @image_uploaded_date = resp.image_pushed_at.to_date.to_s
      resp[:image_uploaded_date] = @image_uploaded_date
    end
    resp
  end

  def resource_id
    @repository_name
  end

  def exists?
    !@repository_name.nil?
  end

  def to_s
    "AWS ECR: #{@repository_name}"
  end
end

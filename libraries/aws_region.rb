require "aws_backend"
require "pry"

class AwsRegion < AwsResourceBase
  name "aws_region"
  desc "Verifies settings for an AWS region."

  example "
    describe aws_region('eu-west-2') do
      it { should exist }
      it { should have_ebs_encryption_enabled }
    end
  "
  attr_reader :region_name, :endpoint, :resp, :opt_in_status, :ebs_encryption_enabled

  def initialize(opts = {})
    opts = { region_name: opts } if opts.is_a?(String)

    super(opts)
    validate_parameters(allow: [:region_name])

    @region_name = opts[:region_name]
    catch_aws_errors do
      @resp = @aws.compute_client.describe_regions({ region_names: [@region_name] })
      return if @resp.regions.empty?
      @ebs_encryption_enabled = fetch_ebs_status_by_region(@region_name)
      @opt_in_status = @resp.regions.first.opt_in_status
      @endpoint = @resp.regions.first.endpoint
    end
  end

  def resource_id
    "#{@region_name}_#{@endpoint}"
  end

  def exists?
    !@endpoint.nil?
  end

  def has_ebs_encryption_enabled?
    @ebs_encryption_enabled
  end

  def to_s
    "Region #{@region_name}"
  end

  private

  def fetch_ebs_status_by_region(region)
    catch_aws_errors do
      new_client = @aws.compute_client
      new_client.config.region = region
      new_client.get_ebs_encryption_by_default[:ebs_encryption_by_default]
    end
  end

end

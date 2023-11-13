require 'aws_backend'

class AwsRegion < AwsResourceBase
  name 'aws_region'
  desc 'Verifies settings for an AWS region.'

  example "
    describe aws_region('eu-west-2') do
      it { should exist }
    end
  "
  attr_reader :region_name, :endpoint

  def initialize(opts = {})
    opts = { region_name: opts } if opts.is_a?(String)

    super(opts)
    validate_parameters(allow: [:region_name])

    @region_name = opts[:region_name]
    catch_aws_errors do
      resp = @aws.compute_client.describe_regions(region_names: [@region_name])
      return if resp.regions.empty?
      @endpoint = resp.regions[0].endpoint
    end
  end

  def resource_id
    "#{@region_name}_#{@endpoint}"
  end

  def exists?
    !@endpoint.nil?
  end

  def to_s
    "Region #{@region_name}"
  end
end

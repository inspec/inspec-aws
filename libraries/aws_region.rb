# frozen_string_literal: true

require 'aws_backend'

class AwsRegion < AwsResourceBase
  name 'aws_region'
  desc 'Verifies settings for an AWS region'

  example "
    describe aws_region('eu-west-2') do
      it { should exist }
    end
  "
  attr_reader :region_name, :endpoint, :exists
  alias exists? exists

  def initialize(opts = {})
    # Call the parent class constructor
    opts = { region_name: opts } if opts.is_a?(String) # this preserves the original scalar interface
    super(opts)
    validate_parameters([:region_name])
    @region_name = opts[:region_name]
    catch_aws_errors do
      begin
        @resp = @aws.compute_client.describe_regions(region_names: [@region_name])
        @exists = !@resp.regions.empty?
      rescue Aws::EC2::Errors::InvalidParameterValue
        @exists = false
      end
      return unless @exists
      @endpoint = @resp.regions[0].endpoint
    end
  end

  def to_s
    "Region #{@region_name}"
  end
end

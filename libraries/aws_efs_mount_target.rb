# frozen_string_literal: true

require 'aws_backend'

class AWSDMSEndpoint < AwsResourceBase
  name 'aws_dms_endpoint'
  desc 'Returns information about the endpoints for your account in the current region.'

  example "
    describe aws_dms_endpoint(endpoint_identifier: 'test') do
      it { should exist }
    end
  "
  def initialize(opts = {})
    opts = { endpoint_identifier: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:endpoint_identifier])

    raise ArgumentError, "#{@__resource_name__}: endpoint_identifier must be provided" unless opts[:endpoint_identifier] && !opts[:endpoint_identifier].empty?
    @display_name = opts[:endpoint_identifier]
    catch_aws_errors do
      resp = @aws.efs_client.describe_mount_targets({ endpoint_identifier: [opts[:endpoint_identifier]] })
      @endpoints = resp.endpoints[0].to_h
      create_resource_methods(@endpoints)
    end
  end

  def id
    return nil unless exists?
    @endpoints[:endpoint_identifier]
  end

  def exists?
    !@endpoints.nil? && !@endpoints.empty?
  end

  def encrypted?
    @endpoints[:encrypted]
  end

  def to_s
    "endpoint_identifier: #{@display_name}"
  end
end

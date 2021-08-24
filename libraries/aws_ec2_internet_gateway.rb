# frozen_string_literal: true

require 'aws_backend'

class AWSEC2InternetGateway < AwsResourceBase
  name 'aws_ec2_internet_gateway'
  desc 'Returns'

  example "
    describe aws_ec2_internet_gateway(function_name: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { function_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:function_name])
    raise ArgumentError, "#{@__resource_name__}: function_name must be provided" unless opts[:function_name] && !opts[:function_name].empty?
    @display_name = opts[:instance_profile_name]
    catch_aws_errors do
      resp = @aws.compute_client.describe_internet_gateways({ function_name: opts[:function_name] })
      @res = resp.configuration.to_h
      create_resource_methods(@res)
    end
  end

  def function_name
    return nil unless exists?
    @res[:function_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Function Name: #{@display_name}"
  end
end

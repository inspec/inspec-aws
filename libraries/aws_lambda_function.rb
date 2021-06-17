# frozen_string_literal: true

require 'aws_backend'

class AWSLambdaFunction < AwsResourceBase
  name 'aws_lambda_function'
  desc 'Returns information about the function'

  example "
    describe aws_lambda_function(function_name: 'test1') do
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
      resp = @aws.lambda_client.get_function({ function_name: opts[:function_name] })
      @res = resp.configuration.to_h
      create_resource_methods(@res)
    end
  end

  def id
    return nil unless exists?
    @res[:function_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def encrypted?
    @res[:encrypted]
  end

  def to_s
    "function_name: #{@display_name}"
  end
end

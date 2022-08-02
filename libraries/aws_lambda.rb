# frozen_string_literal: true

require 'aws_backend'

class AwsLambda < AwsResourceBase
  name 'aws_lambda'
  desc 'Verifies the settings for a set of lambda.'
  example "
    describe aws_lambda('lambda_fred') do
      ....
    end
  "

  attr_reader :tags

  def initialize(opts = {})
    opts = { lambda_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:lambda_name])
    fetch_data (opts[:lambda_name])
  end

  def fetch_data(target)
    @display_name = target
    details = @aws.lambda_client.get_function({ function_name: target })
    @lambda = details.configuration.to_h
    @tags = details.tags
    create_resource_methods(@lambda)
  rescue Aws::Errors::ServiceError
    @lambda = nil
  end

  def exists?
    !@lambda.nil? && !@lambda.empty?
  end

  def name
    @display_name
  end

  def resource_id
    @display_name
  end

  def to_s
    "Lambda #{name}"
  end
end

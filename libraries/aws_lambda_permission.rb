# frozen_string_literal: true

require 'aws_backend'

class AWSLambdaPermission < AwsResourceBase
  name 'aws_lambda_permission'
  desc 'Returns information about the function'

  example "
    describe aws_lambda_policy(function_name: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(function_name Sid))
    raise ArgumentError, "#{@__resource_name__}: function_name must be provided" unless opts[:function_name] && !opts[:function_name].empty?
    raise ArgumentError, "#{@__resource_name__}: statement_id must be provided" unless opts[:Sid] && !opts[:Sid].empty?
    @display_name = opts[:function_name]
    row = []
    catch_aws_errors do
      resp = @aws.lambda_client.get_policy({ function_name: opts[:function_name] })
      statements = JSON.parse(resp.policy)['Statement']
      statements.each do |value|
        row = { sid: value['Sid'],
          effect: value['Effect'],
          principal: value['Principal'],
          action: value['Action'],
          resource: value['Resource'] } if value['Sid'].eql? opts[:Sid]
      end
      create_resource_methods(row.to_h)
    end
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Function Name: #{@display_name}"
  end
end

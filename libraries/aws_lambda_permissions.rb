# frozen_string_literal: true

require 'aws_backend'

class AWSLambdaPermissions < AwsResourceBase
  name 'aws_lambda_permissions'
  desc 'eturns the resource-based IAM policy for a function, version, or alias.'

  example "
    describe aws_lambda_permissions(function_name: 'test1') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:sids,                                  field: :Sid)
             .register_column(:effects,                               field: :Effect)
             .register_column(:principals,                            field: :Principal)
             .register_column(:actions,                               field: :Action)
             .register_column(:resources,                             field: :Resource)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(function_name))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: function_name must be provided" unless opts[:function_name] && !opts[:function_name].empty?
    @query_params[:function_name] = opts[:function_name]
    @table = fetch_data
  end

  def fetch_data
    rows = []
    catch_aws_errors do
      resp = @aws.lambda_client.get_policy({ function_name: opts[:function_name] })
      statements = JSON.parse(resp.policy)['Statement']
      statements.each do |value|
        # next if value['Sid'] != opts[:Sid]
        rows = [{
                  sid: value['Sid'],
                  effect: value['Effect'],
                  principal: value['Principal'],
                  action: value['Action'],
                  resource: value['Resource'],
                }]
      end
      rows.to_h
    end
  end
end

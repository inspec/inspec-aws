# frozen_string_literal: true

require 'aws_backend'

class AwsCloudformationStacks < AwsResourceBase
  name 'aws_cloudformation_stacks'
  desc 'Verifies settings for aws CloudFormation Stacks'

  example "
    describe aws_cloudformation_stacks do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:names, field: :name)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    cloudformation_stacks_rows = []
    catch_aws_errors do
      @api_response = @aws.cloudformation_client.describe_stacks
    end
    return [] if !@api_response || @api_response.empty?
    @api_response.stacks.each do |cf_stack|
      cloudformation_stacks_rows+=[{ name: cf_stack.stack_name }]
    end
    @table = cloudformation_stacks_rows
  end
end

require 'aws_backend'

class AwsCloudformationStacks < AwsResourceBase
  name 'aws_cloudformation_stacks'
  desc 'Verifies settings for aws CloudFormation Stacks.'
  example <<-EXAMPLE
    describe aws_cloudformation_stacks do
      it { should exist }
    end
  EXAMPLE

  attr_reader :table

  FilterTable.create
             .register_column(:names, field: :name)
             .register_column(:creation_times, field: :creation_time)
             .register_column(:stack_ids, field: :stack_id)
             .register_column(:notification_arns, field: :notification_arn)
             .register_column(:role_arns, field: :role_arn)
             .register_column(:parent_ids, field: :parent_id)
             .register_column(:root_ids, field: :root_id)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    cloudformation_stacks_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.cloudformation_client.describe_stacks(pagination_options)
      end
      return cloudformation_stacks_rows if !@api_response || @api_response.empty?
      @api_response.stacks.each do |res|
        cloudformation_stacks_rows+=[{
          name: res.stack_name,
          creation_time: res.creation_time,
          stack_id: res.stack_id,
          notification_arn: res.notification_arns,
          role_arn: res.role_arn,
          parent_id: res.parent_id,
          root_id: res.root_id,
        }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = cloudformation_stacks_rows
  end
end

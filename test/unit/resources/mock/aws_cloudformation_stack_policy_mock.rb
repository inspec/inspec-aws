require_relative 'aws_base_resource_mock'

class AwsCloudformationStackPolicyMock < AwsBaseResourceMock
  def initialize
    super
    @stack = {}
    @stack[:stack_name] = 'testStack'
    stack_policy = {
      Statement: [
        {
          Effect: 'Deny',
          Action: 'Update:*',
          Principal: '*',
          Resource: 'LogicalResourceId/ProductionDatabase',
        },
        {
          Effect: 'Allow',
          Action: 'Update:*',
          Principal: '*',
          Resource: '*',
        },
      ],
    }
    @stack[:stack_policy_body] = stack_policy.to_json
  end

  def stub_data
    statements = {
      client: Aws::CloudFormation::Client,
      method: :get_stack_policy,
      data: {
        stack_policy_body: @stack[:stack_policy_body],
      },
    }
    [statements]
  end

  attr_reader :stack
end

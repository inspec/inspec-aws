require_relative 'aws_base_resource_mock'

class AwsCloudformationStackPolicyMock < AwsBaseResourceMock
  def initialize
    super
    @param_required = {}
    @param_required[:stack_name] = @aws.any_string

    @stack = Hash[@param_required]
    @stack[:stack_name] = "testStack"
    @stack[:stack_policy_body] =  '{Statement: [
                                    {
                                      Effect: "Deny",
                                      Action: "Update:*",
                                      Principal: "*",
                                      Resource: "LogicalResourceId/ProductionDatabase"
                                    },
                                    {
                                      Effect: "Allow",
                                      Action: "Update:*",
                                      Principal: "*",
                                      Resource: "*"
                                    }
                                  ]
                                }'
  end

  def stub_data
    stub_data = []

    statements = { :client => Aws::CloudFormation::Client,
                   :method => :get_stack_policy,
                   :data => { :stack_policy_body => @stack[:stack_policy_body],
                   :stack_name => @stack[:stack_name]
                  }}

    stub_data += [statements]

  end

  def stack
    @stack
  end
end

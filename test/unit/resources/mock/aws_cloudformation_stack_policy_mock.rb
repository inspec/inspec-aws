require_relative 'aws_base_resource_mock'

class AwsCloudformationStackPolicyMock < AwsBaseResourceMock
  def initialize
    super
    @stack_required = {}
    @stack_required[:stack_name] = @aws.any_string

    @stack = Hash[@stack_required]
    @stack[:stack_name] = 'test-stack'
    @stack[:stack_policy_body] = "%7B%0A%20%20%20%20%20%22Statement%22%20%3A%20%5B%0A%20%20%20%20%20%20%20%20%7B%0A%20%20%20%20%20%20%20%20%20%20%22Effect%22%20%3A%20%22Deny%22%2C%0A%20%20%20%20%20%20%20%20%20%20%22Action%22%20%3A%20%22Update%3A*%22%2C%0A%20%20%20%20%20%20%20%20%20%20%22Principal%22%20%3A%20%22*%22%2C%0A%20%20%20%20%20%20%20%20%20%20%22Resource%22%20%3A%20%22LogicalResourceId%2FProductionDatabase%22%0A%20%20%20%20%20%20%20%20%7D%2C%0A%20%20%20%20%20%20%20%20%7B%0A%20%20%20%20%20%20%20%20%20%20%22Effect%22%20%3A%20%22Allow%22%2C%0A%20%20%20%20%20%20%20%20%20%20%22Action%22%20%3A%20%22Update%3A*%22%2C%0A%20%20%20%20%20%20%20%20%20%20%22Principal%22%20%3A%20%22*%22%2C%0A%20%20%20%20%20%20%20%20%20%20%22Resource%22%20%3A%20%22*%22%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%5D%0A%20%20%20%20%7D%0A"
  end

  def stub_data
    stub_data = []

    stack = { :client => Aws::CloudFormation::Client,
               :method => :get_stack_policy,
               :data => { :stack_policy_body => @stack[:stack_policy_body],
                          :stack_name => @stack[:stack_name]
                        }}

    statements = { :client => Aws::CloudFormation::Client,
                   :method => :get_stack_policy,
                   :data => { :stack_policy_body => @stack[:stack_policy_body],
                        :stack_name => @stack[:stack_name]
                      }}

    # stub_data += [stack]
    stub_data += [statements]

  end

  def stack
    @stack
  end
end

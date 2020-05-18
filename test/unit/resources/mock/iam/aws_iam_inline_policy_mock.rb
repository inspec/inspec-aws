require_relative '../aws_base_resource_mock'

class AwsIamInlinePolicyMock < AwsBaseResourceMock
  def initialize
    super
    @policy_required = {}
    @policy_required[:policy_name] = @aws.any_string
    @policy_required[:role_name] = @aws.any_string

    @policy = Hash[@policy_required]
    @policy[:policy_name] = "test-policy"
    @policy[:user_name] = "test-user"
    @policy[:role_name] = "test-role"
    @policy[:group_name] = "test-group"
    @policy[:policy_document] = "%7B%0A%20%20%22Version%22%3A%20%222012-10-17%22%2C%0A%20%20%22Statement%22%3A%20%5B%0A%20%20%20%20%7B%0A%20%20%20%20%20%20%22Action%22%3A%20%5B%0A%20%20%20%20%20%20%20%20%22ec2%3ADescribe%2A%22%0A%20%20%20%20%20%20%5D%2C%0A%20%20%20%20%20%20%22Effect%22%3A%20%22Allow%22%2C%0A%20%20%20%20%20%20%22Resource%22%3A%20%22%2A%22%0A%20%20%20%20%7D%2C%0A%20%20%20%20%7B%0A%20%20%20%20%20%20%22NotAction%22%3A%20%22s3%3ADeleteBucket%22%2C%0A%20%20%20%20%20%20%22Effect%22%3A%20%22Allow%22%2C%0A%20%20%20%20%20%20%22Resource%22%3A%20%22arn%3Aaws%3As3%3A%3A%3A%2A%22%0A%20%20%20%20%7D%0A%20%20%5D%0A%7D%0A"
  end

  def stub_data
    stub_data = []

    policy = { :client => Aws::IAM::Client,
               :method => :get_role_policy,
               :data => { :policy_document => @policy[:policy_document],
                          :policy_name => @policy[:policy_name],
                          :role_name => @policy[:role_name]
                        }}

    statements = { :client => Aws::IAM::Client,
                   :method => :get_role_policy,
                   :data => { :policy_document => @policy[:policy_document],
                        :policy_name => @policy[:policy_name],
                        :role_name => @policy[:role_name]
                      }}

    stub_data += [policy]
    stub_data += [statements]

  end

  def policy
    @policy
  end
end

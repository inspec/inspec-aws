require_relative '../aws_base_resource_mock'

class AwsIamRoleMock < AwsBaseResourceMock

  # Default attributes.
  def initialize
    super
    @role = {
        role: {
            arn: @aws.any_arn,
            assume_role_policy_document: '<URL-encoded-JSON>',
            create_date: @aws.any_date,
            path: '/',
            role_id: 'AIDIODR4TAW7CSEXAMPLE',
            role_name: @aws.any_string,
            description: @aws.any_string
        }
    }
  end

  # Provide the mapping for what to return when mocking calls to the AWS SDK.
  def stub_data
    [{ :client => Aws::IAM::Client, :method => :get_role, :data => @role }]
  end

  def role
    @role
  end
end

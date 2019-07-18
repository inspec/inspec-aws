require_relative '../aws_base_resource_mock'

class AwsIamRoleMock < AwsBaseResourceMock

  # Default attributes.
  def initialize
    super

    @role_name = @aws.any_string
    @attached_policy_name = @aws.any_string
    @attached_policy_arn = @aws.any_arn
    @inline_policy_name = @aws.any_string

    @role = {
        role: {
            arn: @aws.any_arn,
            assume_role_policy_document: '<URL-encoded-JSON>',
            create_date: @aws.any_date,
            path: '/',
            role_id: 'AIDIODR4TAW7CSEXAMPLE',
            role_name: @role_name,
            description: @aws.any_string
        }
    }

    @attached_policies = {
        attached_policies: [
            {policy_name: @attached_policy_name,
             policy_arn: @attached_policy_arn},
            {policy_name: @aws.any_string,
             policy_arn: @aws.any_arn}
        ],
        is_truncated: false,
        marker: nil
    }

    @inline_policies = {
        policy_names:[
            @inline_policy_name, @aws.any_string
        ]
    }

  end

  # Provide the mapping for what to return when mocking calls to the AWS SDK.
  def stub_data
    stub_data = []

    role = { :client => Aws::IAM::Client,
               :method => :get_role,
               :data => @role}

    attached_policies = { :client => Aws::IAM::Client,
               :method => :list_attached_role_policies,
               :data => @attached_policies }

    inline_policies = { :client => Aws::IAM::Client,
               :method => :list_role_policies,
               :data => @inline_policies }

    stub_data += [role]
    stub_data += [attached_policies]
    stub_data += [inline_policies]

  end

  def role
    @role
  end

  def role_name
    @role_name
  end

  def attached_policies
    @attached_policies
  end

  def attached_policy_name
    @attached_policy_name
  end

  def attached_policy_arn
    @attached_policy_arn
  end

  def inline_policies
    @inline_policies
  end

  def inline_policy_name
    @inline_policy_name
  end
end

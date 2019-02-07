require_relative '../aws_base_resource_mock'

class AwsIamPasswordPolicyMock < AwsBaseResourceMock

  # Default attributes.
  def initialize
    super
    # get_user required fields
    @policy = {
        minimum_password_length: @aws.any_int(10),
        require_symbols: false,
        require_numbers: false,
        require_uppercase_characters: false,
        require_lowercase_characters: false,
        allow_users_to_change_password: false,
        max_password_age: @aws.any_int(40),
        password_reuse_prevention: @aws.any_int(10),
        hard_expiry: true,
    }
  end

  # Provide the mapping for what to return when mocking calls to the AWS SDK.
  def stub_data
    stub_data = []

    policy = { :client => Aws::IAM::Client,
               :method => :get_account_password_policy,
               :data => { :password_policy => @policy }}

    stub_data += [policy]
  end

  def policy
    @policy
  end
end
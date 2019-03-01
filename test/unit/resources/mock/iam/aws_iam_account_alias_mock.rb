require_relative '../aws_base_resource_mock'

class AwsIamAccountAliasMock < AwsBaseResourceMock

  # Default attributes.
  def initialize
    super
    @alias = {
      account_aliases: [
        @aws.any_string
      ]
    }
  end

  # Provide the mapping for what to return when mocking calls to the AWS SDK.
  def stub_data
    [{ :client => Aws::IAM::Client, :method => :list_account_aliases, :data => @alias }]
  end

  def alias
    @alias
  end
end

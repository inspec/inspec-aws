require_relative '../aws_base_resource_mock'

class AwsIamAccessKeyMock < AwsBaseResourceMock

  # Default attributes.
  def initialize
    super
    user = "User-#{@aws.any_string}"
    @access_keys =  [
            {
                access_key_id: "AKIA111111111EXAMPLE",
                create_date: @aws.any_date,
                status: "Active",
                user_name: user,
            }
        ]

    @last_used = {
        user_name: user,
        access_key_last_used: {
            last_used_date: @aws.any_date,
            service_name: @aws.any_string,
            region: @aws.any_region
        }
    }
  end

  # Provide the mapping for what to return when mocking calls to the AWS SDK.
  def stub_data
    stub_data = []

    keys = { :client => Aws::IAM::Client,
             :method => :list_access_keys,
             :data => { :access_key_metadata => @access_keys }}

    password = { :client => Aws::IAM::Client,
                 :method => :get_access_key_last_used,
                 :data => @last_used }

    stub_data += [password]
    stub_data += [keys]
  end

  def access_keys
    @access_keys
  end

  def last_used
    @last_used
  end
end
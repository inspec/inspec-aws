require_relative '../aws_base_resource_mock'

class AwsIamUserMock < AwsBaseResourceMock

  # Build method allows consumer to overwrite default values.
  # These will be respected by the stub_data config.
  def self.build
    builder = new
    yield(builder)
    builder.user
  end

  # Default attributes, can be overridden with builder methods.
  def initialize
    super
    # get_user required fields
    @user_required = {}
    @user_required[:arn] = @aws.any_arn
    @user_required[:user_id] = "user-id-#{@aws.any_hex}"
    @user_required[:user_name] = "user-#{@aws.any_hex}"
    @user_required[:path] = @aws.any_string
    @user_required[:create_date] = @aws.any_date

    # Additional enrichment from subsequent calls
    @user = Hash[@user_required]
    @user[:has_console_password] = { user_name: @user[:user_name], create_date: @aws.any_date }
    @user[:access_keys] = nil
    @user[:attached_policy_names] = []
    @user[:attached_policy_arns] = []
    @user[:inline_policy_names] = [""]
    @user[:has_mfa_enabled] = [{ user_name: @user[:user_name],
                                 serial_number: @aws.any_string,
                                 enable_date: @aws.any_date }]
  end

  # Provide the mapping for what to return when mocking calls to the AWS SDK.
  def stub_data
    stub_data = []

    user = { :client => Aws::IAM::Client,
             :method => :get_user,
             :data => { :user => @user_required }}

    password = { :client => Aws::IAM::Client,
                 :method => :get_login_profile,
                 :data => { :login_profile => @user[:has_console_password] }}

    mfa = { :client => Aws::IAM::Client,
            :method => :list_mfa_devices,
            :data => { :mfa_devices => @user[:has_mfa_enabled] }}

    inline_policy = { :client => Aws::IAM::Client,
                      :method => :list_user_policies,
                      :data => { :policy_names => @user[:inline_policy_names] }}

    attached_policy = { :client => Aws::IAM::Client,
                        :method => :list_attached_user_policies,
                        :data => @user[:attached_policy_names] }

    stub_data += [user]
    stub_data += [password]
    stub_data += [mfa]
    stub_data += [inline_policy]
    stub_data += [attached_policy]
  end

  def with_username(username)
    @user[:user_name] = username
  end

  def with_mfa_enabled(enabled = true)
    @user[:has_mfa_enabled] = enabled
  end

  def with_access_keys(access_keys)
    @user[:access_keys] = access_keys
  end

  def user
    @user
  end
end
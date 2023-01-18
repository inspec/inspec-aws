require "aws_backend"

class AwsIamUser < AwsResourceBase
  name "aws_iam_user"
  desc "Verifies settings for an AWS IAM User."
  example "
    describe aws_iam_user(user_name: 'TEST_USER_NAME') do
      it { should exist }
    end
  "

  attr_reader :username, :user_arn, :user_id, :user_path, :user_create_date,
              :user_password_last_used, :permissions_boundary, :user_tags

  def initialize(opts = {})
    opts = { user_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:user_name])

    user = catch_aws_errors do
      iam_client.get_user(user_params).user
    end
    @user_arn = user.arn
    @user_id  = user.user_id
    @username = user.user_name
    @user_path = user.path
    @user_create_date = user.create_date
    @user_password_last_used = user.password_last_used
    @permissions_boundary = user.permissions_boundary
    @user_tags = user.tags
  end

  def resource_id
    @user_arn
  end

  def access_keys
    @access_keys ||= (@aws.iam_client.list_access_keys(user_params).access_key_metadata || [])
  end

  def has_console_password
    login_profile.present?
  end

  alias has_console_password? has_console_password

  def attached_policy_names
    @attached_policy_names ||= policies.map { |p| p[:policy_name] }
  end

  def attached_policy_arns
    @attached_policy_arns ||= policies.map { |p| p[:policy_arn] }
  end

  def has_mfa_enabled
    mfa_devices.present?
  end

  def inline_policy_names
    @inline_policy_names ||= (iam_client.list_user_policies(user_params).policy_names || [])
  end

  alias has_mfa_enabled? has_mfa_enabled

  def exists?
    !@user_arn.nil?
  end

  def to_s
    "IAM User Name: #{@username}"
  end

  private

  def login_profile
    @login_profile ||= catch_aws_errors do
      iam_client.get_login_profile(user_params)
    end
  end

  def policies
    @policies ||= catch_aws_errors do
      iam_client.list_attached_user_policies(user_params).attached_policies
    end || []
  end

  def mfa_devices
    @mfa_devices ||= catch_aws_errors do
      iam_client.list_mfa_devices(user_params).mfa_devices
    end
  end

  def user_params
    { user_name: opts[:user_name] }
  end

  def iam_client
    @aws.iam_client
  end
end

# frozen_string_literal: true

require 'aws_backend'

class AwsIamUser < AwsResourceBase
  name 'aws_iam_user'
  desc 'Verifies settings for an AWS IAM User'

  example "
    describe aws_iam_user(user_name: 'psmith') do
      it { should exist }
    end
  "

  attr_reader :access_keys, :attached_policy_names, :attached_policy_arns,
              :has_console_password, :has_mfa_enabled, :inline_policy_names,
              :username, :user_arn, :user_id

  alias has_mfa_enabled? has_mfa_enabled
  alias has_console_password? has_console_password

  def initialize(opts = {})
    opts = { user_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:user_name])

    catch_aws_errors do
      username   = { user_name: opts[:user_name] }
      iam_client = @aws.iam_client

      begin
        # Basic User attributes
        user = iam_client.get_user(username).user
        @user_arn = user.arn
        @user_id  = user.user_id
        @username = opts[:user_name]

        # Additional attributes
        @has_console_password = has_password?(username)
        @access_keys          = user_access_keys(username)
        @has_mfa_enabled      = !iam_client.list_mfa_devices(username).mfa_devices.empty?
        @inline_policy_names  = iam_client.list_user_policies(username).policy_names

        policies = iam_client.list_attached_user_policies(username).attached_policies
        @attached_policy_arns  = policies.map { |p| p[:policy_arn] }
        @attached_policy_names = policies.map { |p| p[:policy_name] }
      rescue Aws::IAM::Errors::NoSuchEntity
        # If the requested User does not exist
        @user_id = nil
        @user_arn = nil

        @access_keys = []
        @inline_policy_names = []
        @attached_policy_arns = []
        @attached_policy_names = []
      end
    end
  end

  def exists?
    !@user_arn.nil?
  end

  def to_s
    "AWS IAM User #{username}"
  end

  private

  def has_password?(username)
    @aws.iam_client.get_login_profile(username)
    true
  rescue Aws::IAM::Errors::NoSuchEntity
    false
  end

  def user_access_keys(username)
    # Return empty array instead if no keys.
    keys = @aws.iam_client.list_access_keys(username).access_key_metadata
    [] if keys.empty?
  end
end

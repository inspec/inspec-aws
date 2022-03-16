# frozen_string_literal: true

require 'aws_backend'

class AwsIamUser < AwsResourceBase
  name 'aws_iam_user'
  desc 'Verifies settings for an AWS IAM User.'

  example "
    describe aws_iam_user(user_name: 'psmith') do
      it { should exist }
    end
  "

  attr_reader :username, :user_arn, :user_id

  def initialize(opts = {})
    opts = { user_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:user_name])

    user = catch_aws_errors do
      iam_client.get_user(user_params).user
    end
    @user_arn = user.arn
    @user_id  = user.user_id
    @username = opts[:user_name]
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

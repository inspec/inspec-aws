# frozen_string_literal: true

require 'aws_backend'

class AwsIamUsers < AwsResourceBase
  name 'aws_iam_users'
  desc 'Verifies settings for a collection of AWS IAM Users'

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

  attr_reader :table

  FilterTable.create
             .register_column(:usernames,   field: :username)
             .register_column(:user_arns,   field: :user_arn)
             .register_column(:user_ids,    field: :user_id)
             .register_column(:access_keys, field: :access_keys)
             .register_column(:attached_policy_names, field: :attached_policy_names)
             .register_column(:attached_policy_arns,  field: :attached_policy_arns)
             .register_column(:has_console_password,  field: :has_console_password)
             .register_column(:inline_policy_names,   field: :inline_policy_names)
             .register_column(:has_mfa_enabled,       field: :has_mfa_enabled)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters([])
    @table = fetch_data
  end

  def fetch_data
    user_rows = []
    resp = {}
    pagination_options = {}

    loop do
      catch_aws_errors do
        iam_client = @aws.iam_client
        resp = iam_client.list_users(pagination_options)
        users = resp.users

        return [] if !users || users.empty?

        users.each do |u|
          username = { user_name: u.arn.split('/').last }
          policies = iam_client.list_attached_user_policies(username).attached_policies

          user_rows += [{ username:     username[:user_name],
                          user_arn:     u.arn,
                          user_id:      u.user_id,
                          access_keys:  @aws.iam_client.list_access_keys(username),
                          has_mfa_enabled:       !iam_client.list_mfa_devices(username).mfa_devices.empty?,
                          inline_policy_names:   iam_client.list_user_policies(username).policy_names,
                          attached_policy_names: policies.map { |p| p[:policy_name] },
                          attached_policy_arns:  policies.map { |p| p[:policy_arn] },
                          has_console_password:  has_password?(username) }]
        end
      end
      break if resp.marker.nil?
      pagination_options = { marker: resp.marker }
    end
    @table = user_rows
  end

  private

  def has_password?(username)
    @aws.iam_client.get_login_profile(username)
    true
  rescue Aws::IAM::Errors::NoSuchEntity
    false
  end
end

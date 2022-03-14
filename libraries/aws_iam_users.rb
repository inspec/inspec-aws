# frozen_string_literal: true

require 'aws_backend'

class AwsIamUsers < AwsCollectionResourceBase
  name 'aws_iam_users'
  desc 'Verifies settings for a collection of AWS IAM Users.'

  example "
    describe aws_iam_users(user_name: 'psmith') do
      it { should exist }
    end
  "

  attr_reader :table

  alias has_mfa_enabled? has_mfa_enabled
  alias has_console_password? has_console_password

  FilterTable.create
             .register_column(:usernames,   field: :username)
             .register_column(:user_arns,   field: :user_arn)
             .register_column(:user_ids,    field: :user_id)
             .register_column(:access_keys, field: :access_keys)
             .register_column(:has_attached_policies, field: :has_attached_policies)
             .register_column(:attached_policy_names, field: :attached_policy_names)
             .register_column(:attached_policy_arns,  field: :attached_policy_arns)
             .register_column(:has_console_password,  field: :has_console_password)
             .register_column(:has_inline_policies,   field: :has_inline_policies)
             .register_column(:inline_policy_names,   field: :inline_policy_names)
             .register_column(:has_mfa_enabled,       field: :has_mfa_enabled)
             .register_column(:password_ever_used?,   field: :password_ever_used?)
             .register_column(:password_last_used_days_ago, field: :password_last_used_days_ago)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
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

          attached_policies = iam_client.list_attached_user_policies(username).attached_policies
          inline_policies   = iam_client.list_user_policies(username).policy_names

  def lazy_load_attached_policies(row, _condition, _table)
    row[:has_attached_policies] ||= fetch(client: :iam_client, operation: :list_attached_user_policies, kwargs: row[:username])
                                    .flat_map(&:attached_policies)
  end

  def lazy_load_attached_policy_names(row, _condition, _table)
    row[:attached_policy_names] = lazy_load_attached_policies(row, _condition, _table).map { |p| p[:policy_name] }
  end

  def lazy_load_attached_policy_arns(row, _condition, _table)
    row[:attached_policy_arns] = lazy_load_attached_policies(row, _condition, _table).map { |p| p[:policy_arn] }
  end

  def lazy_load_inline_policies(row, _condition, _table)
    row[:inline_policy_names] ||= fetch(client: :iam_client, operation: :list_user_policies, kwargs: row[:username])
                                  .flat_map(&:policy_names)
  end

  def lazy_load_has_inline_policies(row, _condition, _table)
    row[:has_inline_policies] = lazy_load_inline_policies(row, _condition, _table).present?
  end

  def mfa_devices(username)
    fetch(client: :iam_client, operation: :list_mfa_devices, kwargs: username).map(&:mfa_devices)
  end

  def lazy_load_has_mfa_enabled(row, _condition, _table)
    row[:mfa_devices] ||= mfa_devices(row[:username])
    row[:has_mfa_enabled] = row[:mfa_devices].present?
  end
end

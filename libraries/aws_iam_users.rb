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

  FilterTable.create
             .register_column(:usernames,   field: :username)
             .register_column(:user_arns,   field: :user_arn)
             .register_column(:user_ids,    field: :user_id)
             .register_column(:access_keys, field: :access_keys, lazy_instance: :lazy_load_access_keys)
             .register_column(:has_attached_policies, field: :has_attached_policies, lazy_instance: :lazy_load_attached_policies)
             .register_column(:attached_policy_names, field: :attached_policy_names, lazy_instance: :lazy_load_attached_policy_names)
             .register_column(:attached_policy_arns,  field: :attached_policy_arns, lazy_instance: :lazy_load_attached_policy_arns)
             .register_column(:has_console_password,  field: :has_console_password, lazy_instance: :lazy_load_has_console_password)
             .register_column(:has_inline_policies, field: :has_inline_policies, lazy_instance: :lazy_load_has_inline_policies)
             .register_column(:inline_policy_names,   field: :inline_policy_names, lazy_instance: :lazy_load_inline_policies)
             .register_column(:has_mfa_enabled,       field: :has_mfa_enabled, lazy_instance: :lazy_load_has_mfa_enabled)
             .register_column(:password_ever_used?,   field: :password_ever_used?)
             .register_column(:password_last_used_days_ago, field: :password_last_used_days_ago)
             .install_filter_methods_on_resource(self, :table)

  alias has_mfa_enabled? has_mfa_enabled
  alias has_console_password? has_console_password

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  private

  def fetch_data
    catch_aws_errors do
      @aws.iam_client.list_users.flat_map do |response|
        response.users.map do |user|
          {
            username: user.arn.split('/').last,
            user_arn: user.arn,
            user_id: user.user_id,
            password_ever_used?: user.password_last_used.present?,
            password_last_used_days_ago: user.password_last_used.present? ? ((Time.current - user.password_last_used) / (24*60*60)).to_i : 0,
          }
        end
      end
    end
  end

  def lazy_load_has_console_password(row, _condition, _table)
    row[:has_console_password] = fetch(client: :iam_client, operation: :get_login_profile, kwargs: { user_name: row[:username] })
                                 .present?
  end

  def lazy_load_access_keys(row, _condition, _table)
    row[:access_keys] = fetch(client: :iam_client, operation: :list_access_keys, kwargs: { user_name: row[:username] })
                        .flat_map(&:access_key_metadata) || []
  end

  def lazy_load_attached_policies(row, _condition, _table)
    row[:has_attached_policies] ||= fetch(client: :iam_client, operation: :list_attached_user_policies, kwargs: { user_name: row[:username] })
                                    .flat_map(&:attached_policies)
  end

  def lazy_load_attached_policy_names(row, condition, table)
    row[:attached_policy_names] = lazy_load_attached_policies(row, condition, table).map { |p| p[:policy_name] }
  end

  def lazy_load_attached_policy_arns(row, condition, table)
    row[:attached_policy_arns] = lazy_load_attached_policies(row, condition, table).map { |p| p[:policy_arn] }
  end

  def lazy_load_inline_policies(row, _condition, _table)
    row[:inline_policy_names] ||= fetch(client: :iam_client, operation: :list_user_policies, kwargs: { user_name: row[:username] })
                                  .flat_map(&:policy_names)
  end

  def lazy_load_has_inline_policies(row, condition, table)
    row[:has_inline_policies] = lazy_load_inline_policies(row, condition, table).present?
  end

  def mfa_devices(username)
    fetch(client: :iam_client, operation: :list_mfa_devices, kwargs: { user_name: username }).map(&:mfa_devices)
  end

  def lazy_load_has_mfa_enabled(row, _condition, _table)
    row[:mfa_devices] ||= mfa_devices(row[:username])
    row[:has_mfa_enabled] = !row[:mfa_devices].nil? && !row[:mfa_devices].empty? && !row[:mfa_devices][0].empty?
  end
end

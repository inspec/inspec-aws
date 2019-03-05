# frozen_string_literal: true

require 'aws_backend'

class AwsOrganizationsAccounts < AwsResourceBase
  name 'aws_organizations_accounts'
  desc 'Verifies status of child accounts within Organizations service.'
  example '
    describe aws_organizations_accounts do
      its("org_account_names") { should include "foo" }
      its("org_account_ids") { should include "222222222222"}
      its("org_account_emails") { should all match "fancy\+.*\@example\.com" }
      # its("missing_access_role") { should be empty }
    end
  '

  attr_reader :table

  FilterTable.create
             .register_column(:org_account_names,        field: :account_name)
             .register_column(:org_account_ids,          field: :account_id)
             .register_column(:org_account_emails,       field: :account_email)
             .register_column(:org_account_statuses,     field: :account_status)
             .register_column(:org_account_remote_roles, field: :account_remote_role)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    opts[:aws_region] = 'us-east-1'
    super(opts)
    validate_parameters([])
    @table = fetch_data
  end

  def to_s
    'Organizations Accounts'
  end

  def fetch_data
    account_rows = []
    accounts = {}
    pagination_options = {}

    loop do
      catch_aws_errors do
        accounts = @aws.org_client.list_accounts(pagination_options)
        return [] if !accounts || accounts.empty?

        accounts.accounts.each do |a|
          # puts "DEBUG account: #{a.inspect}"
          # role_status = check_remote_role(a.id) unless a.status == 'SUSPENDED'
          # puts "DEBUG role status: #{role_status.inspect}"
          account_rows += [{ account_name: a.name,
                          account_id:      a.id,
                          account_email:   a.email,
                          account_status:  a.status,
                        }]
        end
      end
      break unless accounts.next_token
      pagination_options = { next_token: accounts.next_token }
    end
    @table = account_rows
  end

  # private

  # def check_remote_role (account_id)
  #   remote_creds = @aws.sts_client.assume_role({
  #     role_arn: "arn:aws:iam::#{account_id}:role/OrganizationAccountAccessRole",
  #     role_session_name: "#{account_id}_inspec",
  #   })
  #   remote_iam = Aws::IAM::Client.new(
  #     region: 'us-east-1',
  #     credentials: remote_creds,
  #   )
  #   resp = remote_iam.get_role({
  #     role_name: 'OrganizationAccountAccessRole',
  #   })
  #   resp
  # end
end

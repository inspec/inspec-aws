require 'aws_backend'

class AWSIAMSSHPublicKeys < AwsResourceBase
  name 'aws_iam_ssh_public_keys'
  desc 'Returns information about the SSH public keys associated with the specified IAM user. If none exists, the operation returns an empty list.'

  example "
    describe aws_iam_ssh_public_keys(user_name: 'USER_NAME') do
      it { should exist }
    end
    describe aws_iam_ssh_public_keys do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:user_names, field: :user_name)
             .register_column(:ssh_public_key_ids, field: :ssh_public_key_id)
             .register_column(:statuses, field: :status)
             .register_column(:upload_dates, field: :upload_date)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(allow: %i(user_name))
    @query_params = opts.slice(:user_name)
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.iam_client.list_ssh_public_keys(@query_params).map do |table|
        table.ssh_public_keys.map { |table_name| {
          user_name: table_name.user_name,
          ssh_public_key_id: table_name.ssh_public_key_id,
          status: table_name.status,
          upload_dates: table_name.upload_date,
        }
        }
      end.flatten
    end
  end
end

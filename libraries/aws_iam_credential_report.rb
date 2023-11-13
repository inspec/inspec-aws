require 'csv'
require 'aws_backend'

class AwsIamCredentialReport < AwsCollectionResourceBase
  name 'aws_iam_credential_report'
  desc 'Lists all users in the AWS account and the status of their credentials.'

  example "
    describe aws_iam_credential_report.where(mfa_active: false) do
      it { should_not exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:user, field: :user)
             .register_column(:arn, field: :arn)
             .register_column(:user_creation_time, field: :user_creation_time)
             .register_column(:password_enabled, field: :password_enabled)
             .register_column(:password_last_used, field: :password_last_used)
             .register_column(:password_last_changed, field: :password_last_changed)
             .register_column(:password_next_rotation, field: :password_next_rotation)
             .register_column(:mfa_active, field: :mfa_active)
             .register_column(:access_key_1_active, field: :access_key_1_active)
             .register_column(:access_key_1_last_rotated, field: :access_key_1_last_rotated)
             .register_column(:access_key_1_last_used_date, field: :access_key_1_last_used_date)
             .register_column(:access_key_1_last_used_region, field: :access_key_1_last_used_region)
             .register_column(:access_key_1_last_used_service, field: :access_key_1_last_used_service)
             .register_column(:access_key_2_active, field: :access_key_2_active)
             .register_column(:access_key_2_last_rotated, field: :access_key_2_last_rotated)
             .register_column(:access_key_2_last_used_date, field: :access_key_2_last_used_date)
             .register_column(:access_key_2_last_used_region, field: :access_key_2_last_used_region)
             .register_column(:access_key_2_last_used_service, field: :access_key_2_last_used_service)
             .register_column(:cert_1_active, field: :cert_1_active)
             .register_column(:cert_1_last_rotated, field: :cert_1_last_rotated)
             .register_column(:cert_2_active, field: :cert_2_active)
             .register_column(:cert_2_last_rotated, field: :cert_2_last_rotated)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def to_s
    'IAM Credential Report'
  end

  private

  def fetch_data
    catch_aws_errors do
      @aws.iam_client.generate_credential_report
      begin
        attempts ||= 0
        response = @aws.iam_client.get_credential_report
      rescue Aws::IAM::Errors::ReportInProgress => e
        if (attempts += 1) <= 5
          Inspec::Log.warn "AWS IAM Credential Report still being generated - attempt #{attempts}/5."
          sleep 5
          retry
        else
          Inspec::Log.warn 'AWS IAM Credential Report was not generated quickly enough.'
          raise e
        end
      end
      report = CSV.parse(response.content, headers: true, header_converters: :symbol, converters: [:date_time, lambda { |field| if field == 'true'
                                                                                                                                  true
                                                                                                                                else
                                                                                                                                  field == 'false' ? false : field
                                                                                                                                end
                                                                                                               } ])
      report.map(&:to_h)
    end
  end
end

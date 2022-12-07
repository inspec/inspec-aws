require 'aws_backend'

class AWSIAMVirtualMFADevices < AwsResourceBase
  name 'aws_iam_virtual_mfa_devices'
  desc 'Lists all virtual MFA devices.'

  example "
    describe aws_iam_virtual_mfa_devices do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:serial_numbers, field: :serial_number)
             .register_column(:paths,          field: :path)
             .register_column(:user_names,     field: :user_name)
             .register_column(:user_ids,       field: :user_id)
             .register_column(:arns,           field: :arn)
             .register_column(:tags,           field: :tags)
             .register_column(:enable_dates,   field: :enable_date)
             .register_column(:create_dates,   field: :create_date)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    parameters= {}
    iam_virtual_mfa_device_rows = []
    loop do
      catch_aws_errors do
        @response = @aws.iam_client.list_virtual_mfa_devices(parameters)
      end
      return iam_virtual_mfa_device_rows if !@response || @response.empty?
      @response.virtual_mfa_devices.each do |mfa_device_row|
        iam_virtual_mfa_device_rows += [{
          serial_number:                    mfa_device_row.serial_number,
          path:                             mfa_device_row.user.path,
          user_name:                        mfa_device_row.user.user_name,
          user_id:                          mfa_device_row.user.user_id,
          arn:                              mfa_device_row.user.arn,
          create_date:                      mfa_device_row.user.create_date,
          enable_date:                      mfa_device_row.enable_date,
          tags:                             mfa_device_row.tags,
        }]
      end
      break unless @response.is_truncated
      break unless @response.marker
      parameters[:marker] = @response.marker
    end
    @table = iam_virtual_mfa_device_rows
  end
end

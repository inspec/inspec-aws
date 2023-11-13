require 'aws_backend'

class AwsIamRootUser < AwsResourceBase
  name 'aws_iam_root_user'
  desc 'Verifies settings for AWS Root Account.'
  example "
    describe aws_iam_root_user do
      it { should have_access_key }
    end
  "

  attr_reader :summary_account, :virtual_devices

  def initialize(opts = {})
    super(opts)
    validate_parameters

    catch_aws_errors do
      @summary_account = @aws.iam_client.get_account_summary.summary_map
      @virtual_devices = @aws.iam_client.list_virtual_mfa_devices.virtual_mfa_devices
      @serial_number = @virtual_devices.first.serial_number
    end
  end

  def resource_id
    @serial_number
  end

  def has_access_key?
    @summary_account['AccountAccessKeysPresent'] == 1
  end

  def has_mfa_enabled?
    @summary_account['AccountMFAEnabled'] == 1
  end

  def has_hardware_mfa_enabled?
    has_mfa_enabled? && !has_virtual_mfa_enabled?
  end

  # Virtual MFA devices have suffix 'root-account-mfa-device'
  def has_virtual_mfa_enabled?
    virtual_mfa_suffix = 'root-account-mfa-device'
    @virtual_devices.any? { |device| device[:serial_number].end_with?(virtual_mfa_suffix) }
  end

  def exists?
    !@summary_account.empty?
  end

  def to_s
    'AWS Root-User'
  end
end

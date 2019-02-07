require_relative '../aws_base_resource_mock'

class AwsIamRootUserMock < AwsBaseResourceMock

  # Default attributes.
  def initialize
    super
    @summary_account = {
        # SDK complains if these aren't strings. even though symbols are the right way.
        'AccessKeysPerUserQuota' => 2,
        'AccountAccessKeysPresent' => 1,
        'AccountMFAEnabled' => 0,
        'AccountSigningCertificatesPresent' => 0,
        'AttachedPoliciesPerGroupQuota' => 10,
        'AttachedPoliciesPerRoleQuota' => 10,
        'AttachedPoliciesPerUserQuota' => 10,
        'GroupPolicySizeQuota'=>  5120,
        'Groups' => 15,
        'GroupsPerUserQuota' => 10,
        'GroupsQuota' => 100,
        'MFADevices' => 6,
        'MFADevicesInUse' => 3,
        'Policies' => 8,
        'PoliciesQuota' => 1000,
        'PolicySizeQuota' => 5120,
        'PolicyVersionsInUse' => 22,
        'PolicyVersionsInUseQuota' => 10000,
        'ServerCertificates' => 1,
        'ServerCertificatesQuota' => 20,
        'SigningCertificatesPerUserQuota' => 2,
        'UserPolicySizeQuota'=> 2048,
        'Users' => 27,
        'UsersQuota' => 5000,
        'VersionsPerPolicyQuota' => 5,
    }

    @virtual_devices = [
            {
                serial_number: 'arn:aws:iam::123456789012:mfa/root-account-mfa-device',
            },
        ]
  end

  # Provide the mapping for what to return when mocking calls to the AWS SDK.
  def stub_data
    stub_data = []

    summary = { :client => Aws::IAM::Client,
                :method => :get_account_summary,
                :data => { :summary_map => @summary_account }}

    virtual_devices = { :client => Aws::IAM::Client,
                        :method => :list_virtual_mfa_devices,
                        :data => { :virtual_mfa_devices => @virtual_devices  }}

    stub_data += [summary]
    stub_data += [virtual_devices]
  end

  def summary
    @summary_account
  end

  def virtual_devices
    @virtual_devices
  end
end
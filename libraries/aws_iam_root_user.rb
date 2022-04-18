# frozen_string_literal: true

require 'aws_backend'

class AwsIamRootUser < AwsResourceBase
  name 'aws_iam_root_user'
  desc 'Verifies settings for AWS Root Account.'
  example "
    describe aws_iam_root_user do
      it { should have_access_key }
    end
  "

  attr_reader :summary_account, :virtual_devices,
              :total_access_key_per_user_quota, :total_access_keys_present, :total_account_mfa_enabled,
              :total_account_signing_certificates_present, :total_attached_policies_per_group_quota,
              :total_attached_policies_per_role_quota, :total_attached_policies_per_user_quota,
              :total_global_endpoint_token_version, :total_group_policy_size_quota, :total_groups, :total_groups_per_user_quota,
              :total_groups_quota, :total_mfa_devices, :total_mfa_devices_in_use, :total_policies, :total_policies_quota,
              :total_policy_size_quota, :total_policy_versions_in_use, :total_policy_versions_in_use_quota,
              :total_server_certificates, :total_server_certificates_quota,
              :total_signing_certificates_per_user_quota, :total_user_policy_size_quota,
              :total_users, :total_users_quota, :total_versions_per_policy_quota

  def initialize(opts = {})
    super(opts)
    validate_parameters
    catch_aws_errors do
      @summary_account = @aws.iam_client.get_account_summary.summary_map
      @virtual_devices = @aws.iam_client.list_virtual_mfa_devices.virtual_mfa_devices
    end
    @total_access_key_per_user_quota = @summary_account['AccessKeysPerUserQuota']
    @total_access_keys_present = @summary_account['AccountAccessKeysPresent']
    @total_account_mfa_enabled = @summary_account['AccountMFAEnabled']
    @total_account_signing_certificates_present = @summary_account['AccountSigningCertificatesPresent']
    @total_attached_policies_per_group_quota = @summary_account['AttachedPoliciesPerGroupQuota']
    @total_attached_policies_per_role_quota = @summary_account['AttachedPoliciesPerRoleQuota']
    @total_attached_policies_per_user_quota = @summary_account['AttachedPoliciesPerUserQuota']
    @total_global_endpoint_token_version = @summary_account['GlobalEndpointTokenVersion']
    @total_group_policy_size_quota = @summary_account['GroupPolicySizeQuota']
    @total_groups = @summary_account['Groups']
    @total_groups_per_user_quota = @summary_account['GroupsPerUserQuota']
    @total_groups_quota = @summary_account['GroupsQuota']
    @total_mfa_devices = @summary_account['MFADevices']
    @total_mfa_devices_in_use = @summary_account['MFADevicesInUse']
    @total_policies = @summary_account['Policies']
    @total_policies_quota = @summary_account['PoliciesQuota']
    @total_policy_size_quota = @summary_account['PolicySizeQuota']
    @total_policy_versions_in_use = @summary_account['PolicyVersionsInUse']
    @total_policy_versions_in_use_quota = @summary_account['PolicyVersionsInUseQuota']
    @total_server_certificates = @summary_account['ServerCertificates']
    @total_server_certificates_quota = @summary_account['ServerCertificatesQuota']
    @total_signing_certificates_per_user_quota = @summary_account['SigningCertificatesPerUserQuota']
    @total_user_policy_size_quota = @summary_account['UserPolicySizeQuota']
    @total_users = @summary_account['Users']
    @total_users_quota = @summary_account['UsersQuota']
    @total_versions_per_policy_quota = @summary_account['VersionsPerPolicyQuota']

  end

  def has_access_key?
    @summary_account['AccountAccessKeysPresent'].present?
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

  def has_account_signing_certificate?
    @summary_account['AccountSigningCertificatesPresent'].present?
  end

  def has_mfa_devices_in_use?
    @summary_account['MFADevicesInUse'].present?
  end

  def has_policy_versions_in_use?
    @summary_account['PolicyVersionsInUse'].present?
  end

  def has_users?
    @summary_account['Users'].present?
  end

  def to_s
    'AWS Root-User'
  end
end

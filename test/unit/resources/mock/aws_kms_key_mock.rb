require_relative 'aws_base_resource_mock'

class AwsKmsKeyMock < AwsBaseResourceMock

  def initialize
    super
    @mock_kms_key_enabled = {aws_account_id: @aws.any_id,
                             key_id: @aws.any_id,
                             arn: @aws.any_arn,
                             creation_date: Time.parse(@aws.any_date.to_s),
                             enabled: true,
                             description: "InSpec KMS Key Test Enabled",
                             key_usage: "ENCRYPT_DECRYPT",
                             key_state: "Enabled",
                             origin: "AWS_KMS",
                             key_manager: "CUSTOMER"}

    disabled_aws_key_id  =     @aws.any_id
    disabled_aws_account_arn = @aws.any_arn

    @mock_kms_key_disabled = {aws_account_id: @aws.any_id,
                              key_id: disabled_aws_key_id,
                              arn: disabled_aws_account_arn,
                              creation_date: Time.parse(@aws.any_date.to_s),
                              enabled: false,
                              description: "InSpec KMS Key Test Enabled",
                              key_usage: "ENCRYPT_DECRYPT",
                              key_state: "Disabled",
                              origin: "EXTERNAL",
                              key_manager: "AWS",
                              expiration_model: "KEY_MATERIAL_EXPIRES"
    }

    @mock_alias_kms_key_disabled = {aliases:
                                        [{alias_name:    "alias/#{disabled_aws_key_id}",
                                          alias_arn:     disabled_aws_account_arn,
                                          target_key_id: disabled_aws_key_id},
                                         {alias_name:   "alias/aws/acm",
                                          alias_arn:     "arn:aws:kms:us-west-2:510367013858:alias/aws/acm",
                                          target_key_id: "5e6c2d39-8d66-4df6-942b-25013360a538"}]}
  end

  def stub_data_enabled
    stub_data = []

    kms_key_enabled = {:client => Aws::KMS::Client,
                       :method => :describe_key,
                       :data => {key_metadata: @mock_kms_key_enabled}
    }

    key_rotn =        {:client => Aws::KMS::Client,
                       :method => :get_key_rotation_status,
                       :data => { :key_rotation_enabled => true }
    }

    stub_data += [kms_key_enabled]
    stub_data += [key_rotn]
  end

  def stub_data_disabled
    stub_data = []

    kms_key_disabled =       {:client => Aws::KMS::Client,
                              :method => :describe_key,
                              :data => {key_metadata: @mock_kms_key_disabled}
    }

    alias_kms_key_disabled = {:client => Aws::KMS::Client,
                              :method => :list_aliases,
                              :data => @mock_alias_kms_key_disabled
    }

    key_rotn = {:client => Aws::KMS::Client,
                              :method => :get_key_rotation_status,
                              :data => { :key_rotation_enabled => false }
    }

    stub_data += [kms_key_disabled]
    stub_data += [alias_kms_key_disabled]
    stub_data += [key_rotn]
  end

  def enabled_kms
    @mock_kms_key_enabled
  end

  def disabled_kms
    @mock_kms_key_disabled
  end

  def alias_disabled_kms
    @mock_alias_kms_key_disabled
  end
end

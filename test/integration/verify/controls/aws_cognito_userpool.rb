aws_user_pool_id = attribute("aws_user_pool_id", default: "us-east-2_LNINsLQZz", description: "")

describe aws_cognito_userpool(user_pool_id: aws_user_pool_id) do
  it { should exist }
end

describe aws_cognito_userpool(user_pool_id: aws_user_pool_id) do
  its('id') { should eq aws_user_pool_id }
  its('name') { should eq "test1" }
  
  its('policies.password_policy.minimum_length') { should eq 8 }
  its('policies.password_policy.require_uppercase') { should eq true }
  its('policies.password_policy.require_lowercase') { should eq true }
  its('policies.password_policy.require_numbers') { should eq true }
  its('policies.password_policy.require_symbols') { should eq true }
  its('policies.password_policy.temporary_password_validity_days') { should eq 7 }

  its('lambda_config') { should be_empty }

  # its('lambda_config.pre_sign_up') { should be_empty }
  # its('lambda_config.custom_message') { should be_empty }
  # its('lambda_config.post_confirmation') { should be_empty }
  # its('lambda_config.pre_authentication') { should be_empty }
  # its('lambda_config.post_authenticatio') { should be_empty }
  # its('lambda_config.define_auth_challenge') { should be_empty }
  # its('lambda_config.create_auth_challenge') { should be_empty }
  # its('lambda_config.verify_auth_challenge_response') { should be_empty }
  # its('lambda_config.pre_token_generation') { should be_empty }
  # its('lambda_config.user_migration') { should be_empty }
  # its('lambda_config.custom_sms_sender') { should be_empty }
  # its('lambda_config.custom_email_sender') { should be_empty }
  # its('lambda_config.kms_key_id') { should be_empty }

  its('status') { should be_empty }
  # its('last_modified_date') { should_not be_empty }
  # its('creation_date') { should_not be_empty }

  its('auto_verified_attributes') { should include "email" }
  its('alias_attributes') { should be_empty }
  its('username_attributes') { should be_empty }
  its('sms_verification_message') { should be_empty }
  its('email_verification_message') { should be_empty }
  its('email_verification_subject') { should be_empty }

  its('verification_message_template.sms_message') { should be_empty }
  its('verification_message_template.email_message') { should be_empty }
  its('verification_message_template.email_subject') { should be_empty }
  its('verification_message_template.email_message_by_link') { should be_empty }
  its('verification_message_template.email_subject_by_link') { should be_empty }
  its('verification_message_template.default_email_option') { should eq "CONFIRM_WITH_CODE" }

  its('sms_authentication_message') { should be_empty }
  its('mfa_configuration') { should eq "OFF" }
  its('device_configuration') { should be_empty }
  its('estimated_number_of_users') { should eq 0 }

  its('email_configuration.source_arn') { should be_empty }
  its('email_configuration.reply_to_email_address') { should be_empty }
  its('email_configuration.email_sending_account') { should eq 'COGNITO_DEFAULT' }
  its('email_configuration.from') { should be_empty }
  its('email_configuration.configuration_set') { should be_empty }

  its('sms_configuration') { should be_empty }
  its('user_pool_tags') { should be_empty }
  its('sms_configuration_failure') { should be_empty }
  its('email_configuration_failure') { should be_empty }
  its('domain') { should be_empty }
  its('custom_domain') { should be_empty }

  its('admin_create_user_config.allow_admin_create_user_only') { should eq false }
  its('admin_create_user_config.unused_account_validity_days') { should eq 7 }
  its('admin_create_user_config.invite_message_template') { should be_empty }

  its('user_pool_add_ons') { should be_empty }
end
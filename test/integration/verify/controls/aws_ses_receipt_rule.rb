aws_ses_receipt_rule_name = input(:aws_ses_receipt_rule_name, value: '', description: '')
aws_ses_receipt_rule_rule_set_name = input(:aws_ses_receipt_rule_rule_set_name, value: '', description: '')

control 'aws-ses-receipt-rule-1.0' do
  impact 1.0
  title 'Test the properties of the ses receipt rule.'

  describe aws_ses_receipt_rule(rule_set_name: aws_ses_receipt_rule_rule_set_name, rule_name: aws_ses_receipt_rule_name) do
    it { should exist }
  end

  describe aws_ses_receipt_rule(rule_set_name: aws_ses_receipt_rule_rule_set_name, rule_name: aws_ses_receipt_rule_name) do
    its('name') { should eq aws_ses_receipt_rule_name }
    its('enabled') { should eq true }
    its('tls_policy') { should eq 'Optional' }
    its('recipients') { should include 'test1@test1.com' }

    its('actions') { should_not be_empty }

    its('s3_action_topic_arns') { should_not be_empty }
    its('s3_action_bucket_names') { should_not be_empty }
    its('s3_action_object_key_prefixes') { should_not be_empty }
    its('s3_action_kms_key_arns') { should_not be_empty }
    its('bounce_action_topic_arns') { should_not be_empty }
    its('s3_action_object_key_prefixes') { should_not be_empty }
    its('bounce_action_smtp_reply_codes') { should_not be_empty }
    its('bounce_action_status_codes') { should_not be_empty }
    its('bounce_action_messages') { should_not be_empty }
    its('bounce_action_senders') { should_not be_empty }
    its('workmail_action_topic_arns') { should_not be_empty }
    its('workmail_action_organization_arns') { should_not be_empty }
    its('lambda_action_topic_arns') { should_not be_empty }
    its('lambda_action_function_arns') { should_not be_empty }
    its('lambda_action_invocation_types') { should_not be_empty }
    its('stop_action_scopes') { should_not be_empty }
    its('stop_action_topic_arns') { should_not be_empty }
    its('add_header_action_header_names') { should include 'Custom-Header' }
    its('add_header_action_header_values') { should include 'Added by SES' }
    its('sns_action_topic_arns') { should_not be_empty }
    its('sns_action_encodings') { should_not be_empty }

    its('scan_enabled') { should eq true }
  end

  describe aws_ses_receipt_rule(rule_set_name: 'dummy', rule_name: 'dummy') do
    it { should_not exist }
  end
end

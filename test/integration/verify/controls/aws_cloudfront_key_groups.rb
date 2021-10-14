# frozen_string_literal: true
aws_cloudfront_group_id = attribute('aws_cloudfront_group_id', value: '', description: '')
aws_cloudfront_group_name = attribute('aws_cloudfront_group_name', value: '(none)', description: '')

control 'aws_cloudfront_key_groups-1.0' do
  impact 1.0
  title 'Describes the AWS cloudfront keys group.'
  describe aws_cloudfront_key_groups do
    it { should exist }
    its('key_group_config_names') { should include aws_cloudfront_group_name }
    its('ids') { should include aws_cloudfront_group_id }
  end
end

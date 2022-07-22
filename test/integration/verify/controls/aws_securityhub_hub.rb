skip_control 'aws_securityhub_hub-1.0' do
  impact 1.0
  title 'Test the properties of a Security Hub.'
  
  describe aws_securityhub_hub(hub_arn: '') do
    it { should exist }
    its('hub_arn') { should eq '' }
    its('subscribed_at') { should eq '2021-10-29T11:35:34.308Z'}
    its('auto_enable_controls') { should eq true}
  end
end

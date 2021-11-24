skip_control 'aws_securityhub_hub-1.0' do
  impact 1.0
  title 'Test the properties of a Security Hub.'
  describe aws_securityhub_hub(hub_arn: 'arn:aws:securityhub:us-east-2:1234567890:hub/default') do
    it { should exist }
    its('hub_arn') { should eq 'arn:aws:securityhub:us-east-2:1234567890:hub/default' }
    its('subscribed_at') { should eq "2021-10-29T11:35:34.308Z"}
    its('auto_enable_controls') { should eq true}
  end
end
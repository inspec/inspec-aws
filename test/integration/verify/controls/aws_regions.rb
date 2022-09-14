title 'Test AWS Regions in bulk'

control 'aws-regions-1.0' do
  impact 1.0
  title 'Ensure AWS regions plural resource has the correct properties.'

  describe aws_regions do
    it { should exist }
    its('count') { should be >= 1 }
    its('region_names') { should include 'eu-west-2' }
    its('endpoints') { should include 'ec2.eu-west-2.amazonaws.com' }
  end
end

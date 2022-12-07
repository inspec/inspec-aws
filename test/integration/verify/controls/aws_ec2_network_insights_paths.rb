skip_control 'aws-ec2-network-insights-paths-1.0' do
  impact 1.0
  title 'Test a plural resource of the aws ec2 network insight path.'

  describe aws_ec2_network_insights_paths do
    it { should exist }
  end

  describe aws_ec2_network_insights_paths do
    its('network_insights_path_ids') { should include 'nip-1234567890' }
    its('network_insights_path_arns') { should include 'arn:aws:ec2:us-east-2:1234567890:network-insights-path/nip-1234567890' }
    its('sources') { should include 'igw-1234567890' }
    its('destinations') { should include 'i-1234567890' }
    its('source_ips') { should_not be_empty }
    its('destination_ips') { should_not be_empty }
    its('protocols') { should include 'tcp' }
    its('destination_ports') { should include 22 }
    its('tags') { should_not be_empty }
  end
end
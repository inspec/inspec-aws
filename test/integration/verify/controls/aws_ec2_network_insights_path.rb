skip_control 'aws-ec2-network-insights-path-1.0' do
  title 'Test a singular resource of the aws ec2 network insight path.'

  describe aws_ec2_network_insights_path(network_insights_path_id: 'nip-1234567890') do
    it { should exist }
  end

  describe aws_ec2_network_insights_path(network_insights_path_id: 'nip-1234567890') do
    its('network_insights_path_id') { should eq 'nip-1234567890' }
    its('network_insights_path_arn') { should include 'arn:aws:ec2:us-east-2:1234567890:network-insights-path/nip-1234567890' }
    its('source') { should include 'igw-1234567890' }
    its('destination') { should include 'i-1234567890' }
    its('source_ip') { should eq nil }
    its('destination_ip') { should eq nil }
    its('protocol') { should eq 'tcp' }
    its('destination_port') { should eq 22 }
    its('tags') { should be_empty }
  end
end

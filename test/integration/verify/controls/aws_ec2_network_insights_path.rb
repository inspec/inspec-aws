control 'aws-ec2-network-insights-path-1.0' do
  impact 1.0
  title 'Test a singular resource of the aws ec2 network insight path.'

  describe aws_ec2_network_insights_path(network_insights_path_id: 'nip-01f6ef535c24bda73') do
    it { should exist }
  end

  describe aws_ec2_network_insights_path(network_insights_path_id: 'nip-01f6ef535c24bda73') do
    its('network_insights_path_id') { should eq 'nip-01f6ef535c24bda73' }
    its('network_insights_path_arn') { should include "arn:aws:ec2:us-east-2:112758395563:network-insights-path/nip-01f6ef535c24bda73" }
    # its('created_dates') { should eq false }
    its('source') { should include 'igw-0797cccdc9d73b0e5' }
    its('destination') { should include 'i-0495d385ad28331c7' }
    its('source_ip') { should eq nil }
    its('destination_ip') { should eq nil }
    its('protocol') { should eq 'tcp' }
    its('destination_port') { should eq 22 }
    its('tags') { should be_empty }
  end
end
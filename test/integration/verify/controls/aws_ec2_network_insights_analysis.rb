skip_control 'aws-ec2-network-insights-analysis-1.0' do
  title 'Test a singular resource of the aws ec2 network insight analysis.'

  describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'nia-1234567890') do
    it { should exist }
  end

  describe aws_ec2_network_insights_analysis(network_insights_analysis_id: 'nia-1234567890') do
    its('network_insights_analysis_id') { should eq 'nia-1234567890' }
    its('network_insights_analysis_arn') { should eq 'arn:aws:ec2:us-east-2:1234567890:network-insights-analysis/nia-1234567890' }
    its('network_insights_path_id') { should eq 'nip-1234567890' }
    its('filter_in_arns') { should be_empty }
    its('status') { should eq 'succeeded' }
    its('status_message') { should be_empty }
    its('network_path_found') { should eq false }
    its('forward_path_components') { should be_empty }
    its('return_path_components') { should be_empty }
    its('explanations') { should_not be_empty }
  end
end

skip_control 'aws-ec2-network-insights-analysis-plural-1.0' do

  title 'Test a plural resource of the aws ec2 network insight analysis.'

  describe aws_ec2_network_insights_analysis_plural do
    it { should exist }
  end

  describe aws_ec2_network_insights_analysis_plural do
    its('network_insights_analysis_ids') { should include 'nia-1234567890' }
    its('network_insights_analysis_arns') { should include 'arn:aws:ec2:us-east-2:112758395563:network-insights-analysis/nia-1234567890' }
    its('network_insights_path_ids') { should include 'nip-1234567890' }
    its('filter_in_arns') { should_not be_empty }
    its('statuses') { should include 'succeeded' }
    its('status_messages') { should_not be_empty }
    its('network_path_found') { should include false }
    its('forward_path_components') { should_not be_empty }
    its('return_path_components') { should_not be_empty }
    its('explanations') { should_not be_empty }
  end
end

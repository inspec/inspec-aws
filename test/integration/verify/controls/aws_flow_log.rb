title 'Test single AWS Flow Log'

aws_vpc_flow_log_id = input(:aws_vpc_flow_log_id, value: '', description: 'The AWS VPC identifier with flow log.')
aws_flow_log_id = input(:aws_flow_log_id, value: '', description: 'The AWS flow log ID.')

control 'aws-flow-log-1.0' do
  impact 1.0
  title 'Ensure AWS Flow Log has the correct properties.'

  describe aws_flow_log(vpc_id: aws_vpc_flow_log_id) do
    it { should exist }
    it { should be_attached_to_vpc }
  end

  describe aws_flow_log(flow_log_id: aws_flow_log_id) do
    it { should exist }
    it { should be_attached_to_vpc }
  end

  describe aws_flow_log(aws_flow_log_id) do
    it { should exist }
    it { should be_attached_to_vpc }
  end

  describe aws_flow_log('notthere') do
    it { should_not exist }
  end
end

aws_dms_endpoint_arn = input(:aws_dms_endpoint_arn, value: '', description: '')

control 'aws-endpoint-1.0' do
  impact 1.0
  title 'Ensure AWS DMS Endpoint has the correct properties.'

  describe aws_dms_endpoint(endpoint_arn: aws_dms_endpoint_arn) do
    it { should exist }
  end

  describe aws_dms_endpoint(endpoint_arn: aws_dms_endpoint_arn) do
    its('endpoint_identifier') { should eq 'test1' }
    its('endpoint_type') { should eq 'SOURCE' }
    its('engine_name') { should eq 'aurora' }
    its('engine_display_name') { should eq 'Amazon Aurora MySQL' }
    its('port') { should eq 3306 }
  end

  describe aws_dms_endpoint(endpoint_arn: 'dummy') do
    it { should_not exist }
  end
end
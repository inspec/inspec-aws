aws_endpoint_arn = attribute("aws_endpoint_arn", default: "", description: "")

control 'aws-endpoint-1.0' do
  impact 1.0
  title 'Ensure AWS DMS Endpoint has the correct properties.'

  describe aws_dms_endpoint(endpoint_arn: 'endpoint_arn_value') do
    it { should exist }
  end
end
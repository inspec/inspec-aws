aws_internet_gateway_name_tag = input(:aws_internet_gateway_name_tag, value: '', description: 'The value of the name tag of the internet gateway.')

title 'Test multiple AWS Internet Gateways'

control 'aws-internet-gateways-1.0' do
  impact 1.0
  title 'Check AWS internet gateways have the correct properties.'

  describe aws_internet_gateways do
    it { should exist }
    its('count') { should be >= 1 }
  end

  aws_internet_gateways.ids.each do |id|
    describe aws_internet_gateway(id: id) do
      it { should exist }
    end
  end
end

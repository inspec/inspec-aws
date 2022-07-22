aws_internet_gateway_name_tag = input(:aws_internet_gateway_name_tag, value: '', description: 'The value of the name tag of the internet gateway.')

title 'Test single AWS Internet Gateway'

control 'aws-internet-gateway-1.0' do
  impact 1.0
  title 'Check AWS internet gateway has the correct properties.'

  describe aws_internet_gateway(name: aws_internet_gateway_name_tag) do
    it { should exist }
    it { should be_attached }
    it { should_not be_detached }
  end

  id = aws_internet_gateway(name: aws_internet_gateway_name_tag).id
  describe aws_internet_gateway(id: id) do
    it { should exist }
  end
end

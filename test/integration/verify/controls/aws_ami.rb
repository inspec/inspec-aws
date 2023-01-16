title 'Test a single AWS AMI'

control 'aws-ami-1.0' do
  title 'Ensure AWS AMI has current properties'

  describe aws_ami(image_id: '000000') do
    it { should_not exist }
  end
end

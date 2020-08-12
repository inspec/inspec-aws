title 'Test a single AWS EC2 Image'

control 'aws-ec2-image-1.0' do

  impact 1.0
  title 'Ensure AWS EC2 Image has current properties'

  describe aws_ec2_image(image_id: '000000') do
    it { should_not exist }
  end
end

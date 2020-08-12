title 'Test AWS EC2 Images in bulk'

control 'aws-ec2-images-1.0' do

  impact 1.0
  title 'Ensure AWS EC2 Image has current properties'

  describe aws_ec2_images do
    it { should exist }
  end

  describe aws_ec2_images do
    its('image_ids') { should include 'aki-806d67e4' }
  end
end

title 'Test a single AWS AMI'

control 'aws-ami-1.0' do

  impact 1.0
  title 'Ensure AWS AMI has current properties'

  aws_amis(architecture: 'i386').where { image_type == 'machine' }.image_ids.each do |image|
    describe aws_ami(image_id: image) do
      it { should exist }
      its('architecture') { should eq 'i386' }
      its('image_type')   { should eq 'machine' }
    end
  end

  describe aws_ami(image_id: '000000') do
    it { should_not exist }
  end
end

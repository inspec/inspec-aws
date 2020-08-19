title 'Test AWS AMIs in bulk'

control 'aws-amis-1.0' do

  impact 1.0
  title 'Ensure AWS AMI has current properties'

  aws_amis(architecture: 'i386', platform_details: 'Linux/UNIX' ).where { state == 'available' }.image_ids.each do |image|
    describe aws_ami(image_id: image) do
      it { should exist }
      its('architecture')     { should eq 'i386' }
      its('state')            { should eq 'available' }
      its('platform_details') { should eq 'Linux/UNIX' }
    end
  end
end

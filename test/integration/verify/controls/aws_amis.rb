title 'Test AWS AMIs in bulk'

control 'aws-amis-1.0' do
  title 'Ensure AWS AMI has current properties'

  aws_amis(architecture: 'i386', platform_details: 'Linux/UNIX', is_public: true, hypervisor: 'ovm').where { state == 'available' }.image_ids.each do |image|
    describe aws_ami(image_id: image) do
      it { should exist }
      its('architecture')     { should eq 'i386' }
      its('state')            { should eq 'available' }
      its('platform_details') { should eq 'Linux/UNIX' }
    end
  end

  describe aws_amis(owners: 'self') do
    its('owner_ids.uniq.size') { be 1 }
  end
end

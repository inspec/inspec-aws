title 'Test AWS AMIs in bulk'

control 'aws-amis-1.0' do

  impact 1.0
  title 'Ensure AWS AMI has current properties'

  aws_amis(architecture: 'i386').where { state == 'available' }.image_ids.each do |image|
    describe aws_ami(image_id: image) do
      it { should exist }
      its('architecture') { should eq 'i386' }
      its('state')        { should eq 'available' }
    end
  end

  describe aws_amis(is_public: 'true') do
    it { should exist }
    its('image_owner_alias') { should include 'amazon' }
  end

  describe aws_amis(all_amis: 'true') do
    its('image_owner_alias') { should include 'amazon' }
    its('states')            { should include 'available' }
  end
end

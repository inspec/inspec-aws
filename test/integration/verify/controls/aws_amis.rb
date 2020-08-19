title 'Test AWS AMIs in bulk'

control 'aws-amis-1.0' do

  impact 1.0
  title 'Ensure AWS AMI has current properties'

  describe aws_amis(image_id: 'ami-0a13d44dccf1f5cf6', architecture: 'x86_64') do
    it { should exist }
    its('architectures')      { should include 'x86_64' }
    its('image_ids')          { should include 'ami-0a13d44dccf1f5cf6' }
    its('image_types')        { should include 'machine' }
    its('public')             { should include true }
    its('platform_details')   { should include 'Linux/UNIX' }
    its('image_owner_alias')  { should include 'amazon' }
    its('usage_operations')   { should include 'RunInstances' }
    its('states')             { should include 'available' }
  end

  describe aws_amis(is_public: 'true', platform_details: 'Linux/UNIX') do
    it { should exist }
    its('image_ids') { should include 'ami-0a13d44dccf1f5cf6' }
  end

  describe aws_amis(all_amis: 'true') do
    its('image_ids') { should include 'ami-0a13d44dccf1f5cf6' }
  end
end

aws_ram_resource_share_arn = input(:aws_ram_resource_share_arn, value: '', description: '')

control 'aws-ram-resource-share-1.0' do
  title 'Describes the resource share of the ram.'

  describe aws_ram_resource_share(resource_owner: 'SELF', resource_share_arn: aws_ram_resource_share_arn) do
    it { should exist }
  end

  describe aws_ram_resource_share(resource_owner: 'SELF', resource_share_arn: aws_ram_resource_share_arn) do
    its('resource_share_arn') { should eq aws_ram_resource_share_arn }
    its('name') { should eq 'ResourceShareTest' }
    its('owning_account_id') { should_not eq '1234567890' }
    its('allow_external_principals') { should eq true }
    its('status') { should eq 'ACTIVE' }
    its('status_message') { should be_empty }
    its('tags') { should_not be_empty }
    its('feature_set') { should eq 'STANDARD' }
  end
end

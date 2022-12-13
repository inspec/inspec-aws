aws_ram_resource_share_arn = input(:aws_ram_resource_share_arn, value: '', description: '')

control 'aws-ram-resource-shares-1.0' do
  title 'Lists the resources that you added to a resource shares or the resources that are shared with you.'

  describe aws_ram_resource_shares(resource_owner: 'SELF') do
    it { should exist }
  end

  describe aws_ram_resource_shares(resource_owner: 'SELF') do
    its('resource_share_arns') { should include aws_ram_resource_share_arn }
    its('names') { should include 'ResourceShareTest' }
    its('owning_account_ids') { should_not include '1234567890' }
    its('allow_external_principals') { should include true }
    its('statuses') { should include 'ACTIVE' }
    its('status_messages') { should_not be_empty }
    its('tags') { should_not be_empty }
    its('feature_sets') { should include 'STANDARD' }
  end
end

describe aws_ram_resource_share(resource_owner: "SELF", resource_share_arn: 'arn:aws:ram:us-east-2:112758395563:resource-share/76970b3f-97cf-4dd2-934f-76fc2b43a8e0') do
    it { should exist }
end

describe aws_ram_resource_share(resource_owner: "SELF", resource_share_arn: 'arn:aws:ram:us-east-2:112758395563:resource-share/76970b3f-97cf-4dd2-934f-76fc2b43a8e0') do
    its("resource_share_arn") { should eq "arn:aws:ram:us-east-2:112758395563:resource-share/76970b3f-97cf-4dd2-934f-76fc2b43a8e0" }
    its("name") { should eq "test1" }
    its("owning_account_id") { should eq "112758395563" }
    its("allow_external_principals") { should eq true }
    its("status") { should eq "ACTIVE" }
    its("status_message") { should be_empty }
    its("tags") { should be_empty }
    # its("creation_time") { should_not be_empty }
    # its("last_updated_time")  { should_not be_empty }
    its("feature_set") { should eq "STANDARD" }
end
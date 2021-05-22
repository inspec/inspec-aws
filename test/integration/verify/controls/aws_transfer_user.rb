describe aws_transfer_user(server_id: "s-a04cea62ca52425fa", user_name: 'test@test.com') do
    it { should exist }
end

describe aws_transfer_user(server_id: "s-a04cea62ca52425fa", user_name: 'test@test.com') do
    its('server_id') { should eq 's-a04cea62ca52425fa' }
    its('user.arn') { should eq 'arn:aws:transfer:us-east-2:112758395563:user/s-a04cea62ca52425fa/test@test.com' }
    its('user.home_directory') { should be_empty }
    its('user.home_directory_mappings') { should be_empty }
    its('user.home_directory_mappings.first.entry') { should be_empty }
    its('user.home_directory_mappings.first.target') { should be_empty }
    its('user.home_directory_type') { should eq 'PATH' }
    its('user.policy') { should be_empty }
    its('user.role') { should eq 'arn:aws:iam::112758395563:role/aws-service-role/ops.apigateway.amazonaws.com/AWSServiceRoleForAPIGateway' }
    its('user.ssh_public_keys') { should be_empty }
    its('user.tags') { should be_empty }
    its('user.user_name') { should eq 'test@test.com' }
end
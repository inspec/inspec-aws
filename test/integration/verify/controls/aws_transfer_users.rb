describe aws_transfer_users(server_id: "s-a04cea62ca52425fa") do
    it { should exist }
end

describe aws_transfer_users(server_id: "s-a04cea62ca52425fa") do
    its('arns') { should include 'arn:aws:transfer:us-east-2:112758395563:user/s-a04cea62ca52425fa/test@test.com' }
    its('home_directories') { should_not be_empty }
    its('home_directory_types') { should include 'PATH' }
    its('roles') { should include 'arn:aws:iam::112758395563:role/aws-service-role/ops.apigateway.amazonaws.com/AWSServiceRoleForAPIGateway' }
    its('ssh_public_key_counts') { should include 0 }
    its('user_names') { should include 'test@test.com' }
end
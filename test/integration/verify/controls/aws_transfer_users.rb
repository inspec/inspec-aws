aws_transfer_user_name = input(:aws_transfer_user_name, value: '', description: '')
aws_transfer_server_id = input(:aws_transfer_server_id, value: '', description: '')
aws_transfer_user_arn = input(:aws_transfer_user_arn, value: '', description: '')

control 'aws-transfer-users-1.0' do
      title 'Ensure AWS CloudFormation Transfer Users has the correct properties.'

    describe aws_transfer_users(server_id: aws_transfer_server_id) do
        it { should exist }
    end

    describe aws_transfer_users(server_id: aws_transfer_server_id) do
        its('arns') { should include aws_transfer_user_arn }
        its('home_directories') { should_not be_empty }
        its('home_directory_types') { should include 'LOGICAL' }
        its('roles') { should_not include 'arn:aws:iam::112758395563:role/tf-test-transfer-user-iam-tu-role' }
        its('ssh_public_key_counts') { should include 0 }
        its('user_names') { should include aws_transfer_user_name }
    end
end

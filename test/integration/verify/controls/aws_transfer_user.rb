aws_transfer_user_name = input(:aws_transfer_user_name, value: '', description: '')
aws_transfer_server_id = input(:aws_transfer_server_id, value: '', description: '')
aws_transfer_user_arn = input(:aws_transfer_user_arn, value: '', description: '')

control 'aws-transfer-user-1.0' do
      title 'Ensure AWS CloudFormation Transfer User has the correct properties.'

    describe aws_transfer_user(server_id: aws_transfer_server_id, user_name: aws_transfer_user_name) do
        it { should exist }
    end

    describe aws_transfer_user(server_id: aws_transfer_server_id, user_name: aws_transfer_user_name) do
        its('server_id') { should eq aws_transfer_server_id }
        its('arn') { should eq aws_transfer_user_arn }
        its('home_directory') { should be_empty }
        its('home_directory_mappings') { should_not be_empty }
        its('home_directory_mappings.first.entry') { should_not be_empty }
        its('home_directory_mappings.first.target') { should_not be_empty }
        its('home_directory_type') { should eq 'LOGICAL' }
        its('policy') { should be_empty }
        its('role') { should_not eq 'arn:aws:iam::112758395563:role/tf-test-transfer-user-iam-tu-role' }
        its('ssh_public_keys') { should be_empty }
        its('tags') { should be_empty }
        its('user_name') { should eq aws_transfer_user_name }
    end
end

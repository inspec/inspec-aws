control 'aws-auto-user-pools-1.0' do
    impact 1.0
    title 'Ensure AWS User Pool has the correct properties.'
  
    describe aws_cognito_userpools do
        it { should exist }
    end
end

control 'aws-auto-user-pools-1.0' do
    impact 1.0
    title 'Ensure AWS User Pool has the correct properties.'
  
    describe aws_cognito_userpools do
        its('identity_pool_ids') { should include 'identity_pool_id' }
        its('identity_pool_names') { should include 'identity_pool_name' }
    end
end
control 'aws-auto-user-pools-1.0' do
    impact 1.0
    title 'Ensure AWS User Pool has the correct properties.'
  
    describe aws_cognito_userpools do
        it { should exist }
    end
end
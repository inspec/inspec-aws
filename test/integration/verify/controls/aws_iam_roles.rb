aws_iam_role_name = input(:aws_iam_role_generic_name, value: '', description: 'The AWS IAM Role name.')

control 'AWS IAM Role search for default AWS role' do
  impact 1.0
  title 'Test the AWS IAM Roles'
  
  describe aws_iam_roles do
    its('role_names') { should include aws_iam_role_name }
  end

  # Ensure no Roles have `max_session_duration` greater or equal to 2hrs.
  describe aws_iam_roles.where{ max_session_duration >= (60*120) } do
    it { should_not exist }
  end
end

aws_iam_user_name = input(:aws_iam_user_name, value: '', description: 'The AWS IAM Username.')
aws_iam_access_key = input(:aws_iam_access_key_id, value: '', description: 'The AWS IAM Access Key ID.')
invalid_username = 'i-do-not-exist'
invalid_key_id = 'AKIA1111111111111111'

control 'aws-iam-access-key-1.0' do
  impact 1.0
  title 'Ensure AWS IAM Access Key has the correct properties.'

  # Neither user nor access key ID exist
  describe aws_iam_access_key(username: invalid_username, id: invalid_key_id) do
    it { should_not exist }
  end

  # User exists but has no keys
  describe aws_iam_access_key(username: aws_iam_user_name, id: invalid_key_id) do
    it { should_not exist }
  end

  # User exists and has an access key
  describe aws_iam_access_key(username: aws_iam_user_name, id: aws_iam_access_key) do
    it { should exist }
  end

  # Ensure create_date & last_used_date are set
  describe aws_iam_access_key(username: aws_iam_user_name, id: aws_iam_access_key) do
    it('create_date')     { should_not be_nil }
    it('last_used_date')  { should_not be_nil }
  end
end

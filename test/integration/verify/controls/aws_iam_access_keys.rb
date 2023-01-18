aws_iam_user_name = input(:aws_iam_user_name, value: '', description: 'The AWS IAM Username.')
aws_iam_access_key = input(:aws_iam_access_key_id, value: '', description: 'The AWS IAM Access Key ID.')
invalid_username = 'i-do-not-exist'

control 'aws-iam-access-keys-1.0' do
  title 'Ensure AWS IAM Access Key has the correct properties.'

  describe aws_iam_access_keys do
    it { should exist }
  end

  # Get keys for a valid user
  describe aws_iam_access_keys.where(username: aws_iam_user_name) do
    its('entries.length') { should be 1 }
    its('access_key_ids.first') { should eq aws_iam_access_key }
  end

  # Get Active keys
  describe aws_iam_access_keys.where(active: true) do
    it { should exist }
    its('access_key_ids') { should include aws_iam_access_key }
  end

  # Ensure no Inactive keys
  describe aws_iam_access_keys.where(inactive: true) do
    it { should_not exist }
  end

  # There are recently used keys
  # describe aws_iam_access_keys.where(ever_used: true).where { last_used_days_ago > 0 } do
  #   it { should exist }
  # end

  # Key should be created with user
  # describe aws_iam_access_keys.where(created_with_user: true) do
  #   it { should exist }
  # end

  # No key for invalid user
  describe aws_iam_access_keys(username: invalid_username) do
    it { should_not exist }
  end
end

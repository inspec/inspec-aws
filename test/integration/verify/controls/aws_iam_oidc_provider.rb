open_id_connect_provider_arn = input(:oidc_arn, value: '', description: '')

title 'Test an IAM OIDC Provider'

control 'aws-iam-oidc-provider-1.0' do
  title 'Ensure AWS IAM OIDC Provider has the correct properties.'

  describe aws_iam_oidc_provider(open_id_connect_provider_arn: open_id_connect_provider_arn) do
    it { should exist }
    its('url') { should eq 'accounts.google.com' }
    its('create_date') { should eq Time.parse('2021-08-17 02:00:04.894000000 +0000') }
    its('tags') { should eq test => test_iam }
  end
end


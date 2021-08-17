# frozen_string_literal: true

describe aws_iam_oidc_provider(open_id_connect_provider_arn: 'arn:aws:iam::112758395563:oidc-provider/accounts.google.com') do
  it { should exist }
  its('url') { should eq 'accounts.google.com' }
  its('create_date') { should eq Time.parse('2021-08-17 02:00:04.894000000 +0000') }
  its('tags') { should eq test => test_iam }
end


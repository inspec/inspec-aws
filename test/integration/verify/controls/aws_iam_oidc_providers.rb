# frozen_string_literal: true

describe aws_iam_oidc_providers do
  it { should exist }
  its('arns') { should include 'arn:aws:iam::112758395563:oidc-provider/accounts.google.com' }
end


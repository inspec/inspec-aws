open_id_connect_provider_arn = input(:oidc_arn, value: '', description: '')

title 'Test an IAM OIDC Providers'

control 'aws-iam-oidc-providers-1.0' do
  title 'Ensure AWS IAM OIDC Providers has the correct properties.'

  describe aws_iam_oidc_providers do
    it { should exist }
    its('arns') { should include open_id_connect_provider_arn }
  end
end


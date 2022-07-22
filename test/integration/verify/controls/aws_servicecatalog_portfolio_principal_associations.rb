aws_servicecatalog_portfolio_sm_id = input(:aws_servicecatalog_portfolio_sm_id, value: '', description: '')
aws_iam_role_sc_test_sm_arn = input(:aws_iam_role_sc_test_sm_arn, value: '', description: '')

control 'aws-service-catalog-principal-associations-1.0' do
  impact 1.0
  title 'Lists all principal ARNs associated with the specified portfolio.'

  describe aws_servicecatalog_portfolio_principal_associations(portfolio_id: aws_servicecatalog_portfolio_sm_id) do
    it { should exist }
  end

  describe aws_servicecatalog_portfolio_principal_associations(portfolio_id: aws_servicecatalog_portfolio_sm_id) do
    its('principal_arns') { should include aws_iam_role_sc_test_sm_arn }
    its('principal_types') { should include 'IAM' }
  end

  describe aws_servicecatalog_portfolio_principal_associations(portfolio_id: 'dummy') do
    it { should_not exist }
  end
end

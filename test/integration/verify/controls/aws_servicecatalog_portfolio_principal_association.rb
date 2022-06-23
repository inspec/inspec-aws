aws_servicecatalog_portfolio_sm_id = input(:aws_servicecatalog_portfolio_sm_id, value: '', description: '')
aws_iam_role_sc_test_sm_arn = input(:aws_iam_role_sc_test_sm_arn, value: '', description: '')

control 'aws-service-catalog-principal-association-1.0' do
  impact 1.0
  title 'Describes a principal ARNs associated with the specified portfolio.'

  describe aws_servicecatalog_portfolio_principal_association(portfolio_id: aws_servicecatalog_portfolio_sm_id) do
    it { should exist }
  end

  describe aws_servicecatalog_portfolio_principal_association(portfolio_id: aws_servicecatalog_portfolio_sm_id) do
    its('principal_arn') { should eq aws_iam_role_sc_test_sm_arn }
    its('principal_type') { should eq 'IAM' }
  end

  describe aws_servicecatalog_portfolio_principal_association(portfolio_id: 'dummy') do
    it { should_not exist }
  end
end

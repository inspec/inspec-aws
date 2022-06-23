aws_servicecatalog_product_sm_id = input(:aws_servicecatalog_product_sm_id, value: '', description: '')
aws_servicecatalog_portfolio_sm_id = input(:aws_servicecatalog_portfolio_sm_id, value: '', description: '')
aws_servicecatalog_constraint_sm_id = input(:aws_servicecatalog_constraint_sm_id, value: '', description: '')

control 'aws-service-catalog-launch-role-constraints-1.0' do
  impact 1.0
  title 'Lists the constraints for the specified portfolio and product.'

  describe aws_servicecatalog_launch_role_constraints(portfolio_id: aws_servicecatalog_portfolio_sm_id) do
    it { should exist }
  end

  describe aws_servicecatalog_launch_role_constraints(portfolio_id: aws_servicecatalog_portfolio_sm_id) do
    its('constraint_ids') { should include aws_servicecatalog_constraint_sm_id }
    its('types') { should include 'LAUNCH' }
    its('descriptions') { should include 'Test Description.' }
    its('owners') { should_not be_empty }
    its('product_ids') { should include aws_servicecatalog_product_sm_id }
    its('portfolio_ids') { should include aws_servicecatalog_portfolio_sm_id }
  end

  describe aws_servicecatalog_launch_role_constraints(portfolio_id: 'dummy') do
    it { should_not exist }
  end
end

aws_servicecatalog_product_sm_id = input(:aws_servicecatalog_product_sm_id, value: '', description: '')
aws_servicecatalog_portfolio_sm_id = input(:aws_servicecatalog_portfolio_sm_id, value: '', description: '')
aws_servicecatalog_portfolio_sm_arn = input(:aws_servicecatalog_portfolio_sm_id, value: '', description: '')

control 'aws-service-catalog-product-portfolio-associations-1.0' do
  title 'Lists all principal ARNs associated with the specified portfolio.'

  describe aws_servicecatalog_portfolio_product_associations(product_id: aws_servicecatalog_product_sm_id) do
    it { should exist }
  end

  describe aws_servicecatalog_portfolio_product_associations(product_id: aws_servicecatalog_product_sm_id) do
    its('ids') { should include aws_servicecatalog_portfolio_sm_id }
    its('arns') { should include aws_servicecatalog_portfolio_sm_arn }
    its('display_names') { should include 'My App Portfolio' }
    its('descriptions') { should include 'Test Description.' }
    its('created_times') { should_not be_empty }
    its('provider_names') { should include 'Brett' }
  end

  describe aws_servicecatalog_portfolio_product_associations(product_id: 'dummy') do
    it { should_not exist }
  end
end

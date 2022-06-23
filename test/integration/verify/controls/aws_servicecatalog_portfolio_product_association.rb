aws_servicecatalog_product_sm_id = input(:aws_servicecatalog_product_sm_id, value: '', description: '')
aws_servicecatalog_portfolio_sm_id = input(:aws_servicecatalog_portfolio_sm_id, value: '', description: '')
aws_servicecatalog_portfolio_sm_arn = input(:aws_servicecatalog_portfolio_sm_id, value: '', description: '')

control 'aws-service-catalog-product-portfolio-association-1.0' do
  impact 1.0
  title 'Describes a principal ARNs associated with the specified portfolio.'

  describe aws_servicecatalog_portfolio_product_association(product_id: aws_servicecatalog_product_sm_id) do
    it { should exist }
  end

  describe aws_servicecatalog_portfolio_product_association(product_id: aws_servicecatalog_product_sm_id) do
    its('id') { should eq aws_servicecatalog_portfolio_sm_id }
    its('arn') { should eq aws_servicecatalog_portfolio_sm_arn }
    its('display_name') { should eq 'My App Portfolio' }
    its('description') { should eq 'Test Description.' }
    its('provider_name') { should eq 'Brett' }
  end

  describe aws_servicecatalog_portfolio_product_association(product_id: 'dummy') do
    it { should_not exist }
  end
end

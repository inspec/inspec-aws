# aws_servicecatalog_product_sm_id = attribute("aws_servicecatalog_product_sm_id", value: "prodview-5tim3w4vrjtfk", description: "")

control 'aws-service-catalog-products-1.0' do
  impact 1.0
  title 'Describes the products of the service catalog.'

  describe aws_servicecatalog_cloud_formation_products(name: 'ProductTest') do
    it { should exist }
  end

  describe aws_servicecatalog_cloud_formation_products(name: 'ProductTest') do
    its('ids') { should include aws_servicecatalog_product_sm_id }
    its('product_ids') { should include "prod-wjwzzgbzn6ti6" }
    its('names') { should include 'ProductTest' }
    its('owners') { should include 'test' }
    its('short_descriptions') { should be_empty }
    its('types') { should include 'CLOUD_FORMATION_TEMPLATE' }
    its('distributors') { should be_empty }
    its('has_default_paths') { should include false }
    its('support_emails') { should be_empty }
    its('support_descriptions') { should be_empty }
    its('support_urls') { should be_empty }
  end
end
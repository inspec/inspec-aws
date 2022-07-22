aws_servicecatalog_product_sm_id = input(:aws_servicecatalog_product_sm_id, value: '', description: '')

control 'aws-service-catalog-product-1.0' do
  impact 1.0
  title 'Describes the product of the service catalog.'

  describe aws_servicecatalog_cloud_formation_product(name: 'ProductTest') do
    it { should exist }
  end

  describe aws_servicecatalog_cloud_formation_product(name: 'ProductTest') do
    its('product_view_detail.product_view_summary.id') { should eq aws_servicecatalog_product_sm_id }
    its('product_view_detail.product_view_summary.product_id') { should eq "prod-wjwzzgbzn6ti6" }
    its('product_view_detail.product_view_summary.name') { should eq 'ProductTest' }
    its('product_view_detail.product_view_summary.owner') { should eq 'test' }
    its('product_view_detail.product_view_summary.short_description') { should be_empty }
    its('product_view_detail.product_view_summary.type') { should eq 'CLOUD_FORMATION_TEMPLATE' }
    its('product_view_detail.product_view_summary.distributor') { should be_empty }
    its('product_view_detail.product_view_summary.has_default_path') { should eq false }
    its('product_view_detail.product_view_summary.support_email') { should be_empty }
    its('product_view_detail.product_view_summary.support_description') { should be_empty }
    its('product_view_detail.product_view_summary.support_url') { should be_empty }
  end

  describe aws_servicecatalog_cloud_formation_product(name: 'ProductTest') do
    its('product_view_detail.status') { should eq 'CREATED' }
    its('product_view_detail.product_arn') { should_not be_empty }
  end

  describe aws_servicecatalog_cloud_formation_product(name: 'ProductTest') do
    its('provisioning_artifact_summaries') { should_not be_empty }
  end

  describe aws_servicecatalog_cloud_formation_product(name: 'ProductTest') do
    its('tags') { should be_empty }
    its('tag_options') { should be_empty }
    its('budgets') { should be_empty }
  end

  describe aws_servicecatalog_cloud_formation_product(name: 'dummy') do
    it { should_not exist }
  end
end



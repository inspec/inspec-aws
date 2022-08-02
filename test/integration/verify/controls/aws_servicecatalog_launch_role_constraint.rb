aws_servicecatalog_portfolio_sm_id = input(:aws_servicecatalog_portfolio_sm_id, value: '', description: '')
aws_servicecatalog_portfolio_sm_arn = input(:aws_servicecatalog_portfolio_sm_arn, value: '', description: '')

control 'aws-service-catalog-launch-role-constraint-1.0' do
  impact 1.0
  title 'Describes the launch role constraint of the service catalog.'

  describe aws_servicecatalog_launch_role_constraint(id: aws_servicecatalog_portfolio_sm_id) do
    it { should exist }
  end

  describe aws_servicecatalog_launch_role_constraint(id: aws_servicecatalog_portfolio_sm_id) do
    its('portfolio_detail.id') { should eq aws_servicecatalog_portfolio_sm_id }
    its('portfolio_detail.arn') { should eq aws_servicecatalog_portfolio_sm_arn }
    its('portfolio_detail.display_name') { should eq 'My App Portfolio' }
    its('portfolio_detail.description') { should eq 'Test Description.' }
    its('portfolio_detail.provider_name') { should eq 'Brett' }
  end

  describe aws_servicecatalog_launch_role_constraint(id: aws_servicecatalog_portfolio_sm_id) do
    its('tags') { should be_empty }
    its('tag_options') { should be_empty }
    its('budgets') { should be_empty }
  end

  describe aws_servicecatalog_launch_role_constraint(id: 'dummy') do
    it { should_not exist }
  end
end



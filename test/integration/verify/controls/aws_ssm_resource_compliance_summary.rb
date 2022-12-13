title 'Test a single AWS SSM Resource Compliance Summary'

control 'aws-ssm-resource-compliance-summary-1.0' do
  title 'Ensure AWS SSM Resource Compliance Summary has current properties'

  describe aws_ssm_resource_compliance_summary(resource_id: "dummy") do
    it { should_not exist }
  end
end

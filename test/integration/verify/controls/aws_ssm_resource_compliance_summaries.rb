title 'Test AWS SSM Resource Compliance Summaries in bulk'

control 'aws-ssm-resource-compliance-summaries-1.0' do
  title 'Ensure AWS SSM Resource Compliance Summary has current properties'

  describe.one do
    describe aws_ssm_resource_compliance_summaries do
      it { should_not exist }
    end

    describe aws_ssm_resource_compliance_summaries do
      it { should exist }
    end
  end
end

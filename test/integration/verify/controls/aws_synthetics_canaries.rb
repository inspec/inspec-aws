aws_synthetics_canary_name = input(:aws_synthetics_canary_name, value: "", description: "")

control 'aws_synthetics_canaries-1.0' do
  impact 1.0
  title 'Test the properties of the synthetics canaries.'

  describe aws_synthetics_canaries do
    it { should exist }
  end

  describe aws_synthetics_canaries do
    its('names') { should include aws_synthetics_canary_name }
    its('codes') { should_not be_empty }
    its('execution_role_arns') { should_not be_empty }
    its('schedules') { should_not be_empty }
    its('run_configs') { should_not be_empty }
    its('success_retention_period_in_days') { should include 2 }
    its('failure_retention_period_in_days') { should include 14 }
    its('statuses') { should_not be_empty }
    its('timelines') { should_not be_empty }
    its('artifact_s3_locations') { should_not be_empty }
    its('engine_arns') { should_not be_empty }
    its('runtime_versions') { should_not be_empty }
    its('vpc_configs') { should_not be_empty }
    its('visual_references') { should_not be_empty }
    its('tags') { should_not be_empty }
    its('artifact_configs') { should_not be_empty }
  end
end

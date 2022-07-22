aws_synthetics_canary_name = input(:aws_synthetics_canary_name, value: "", description: "")
aws_synthetics_canary_status = input(:aws_synthetics_canary_status, value: "", description: "")
aws_synthetics_canary_source_location_arn = input(:aws_synthetics_canary_source_location_arn, value: "", description: "")
aws_synthetics_canary_execution_role_arn = input(:aws_synthetics_canary_execution_role_arn, value: "", description: "")
aws_synthetics_canary_engine_arn = input(:aws_synthetics_canary_engine_arn, value: "", description: "")
aws_synthetics_canary_artifact_s3_location = input(:aws_synthetics_canary_artifact_s3_location, value: "", description: "")

control 'aws_synthetics_canary-1.0' do
  impact 1.0
  title 'Test the properties of the synthetics canary.'

  describe aws_synthetics_canary(name: aws_synthetics_canary_name) do
    it { should exist }
  end

  describe aws_synthetics_canary(name: aws_synthetics_canary_name) do
    its('name') { should eq aws_synthetics_canary_name }
    its('code.source_location_arn') { should eq aws_synthetics_canary_source_location_arn }
    its('code.handler') { should eq 'signIn.handler' }
    its('execution_role_arn') { should eq aws_synthetics_canary_execution_role_arn }
    its('schedule.expression') { should eq 'rate(1 hour)' }
    its('schedule.duration_in_seconds') { should eq 0 }
    its('run_config.timeout_in_seconds') { should eq 840 }
    its('run_config.memory_in_mb') { should eq 1000 }
    its('run_config.active_tracing') { should eq false }
    its('success_retention_period_in_days') { should eq 2 }
    its('failure_retention_period_in_days') { should eq 14 }
    its('status.state') { should eq aws_synthetics_canary_status }
    its('status.state_reason') { should be_empty }
    its('status.state_reason_code') { should be_empty }
    its('timeline.last_stopped') { should be_empty }
    its('artifact_s3_location') { should eq aws_synthetics_canary_artifact_s3_location }
    its('engine_arn') { should eq aws_synthetics_canary_engine_arn }
    its('runtime_version') { should eq 'syn-nodejs-puppeteer-3.1' }
    its('vpc_config.vpc_id') { should be_empty }
    its('vpc_config.subnet_ids') { should be_empty }
    its('vpc_config.security_group_ids') { should be_empty }
    its('visual_reference.base_screenshots') { should be_empty }
    its('visual_reference.base_screenshots[0].screenshot_name') { should be_empty }
    its('visual_reference.base_screenshots[0].ignore_coordinates') { should be_empty }
    its('visual_reference.base_canary_run_id') { should be_empty }
    its('artifact_config.s3_encryption.encryption_mode') { should be_empty }
    its('artifact_config.s3_encryption.kms_key_arn') { should be_empty }
  end
end

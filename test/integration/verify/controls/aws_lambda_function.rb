describe aws_lambda_function(function_name: "test_Lambda") do
    it { should exist }
  end
  
  describe aws_lambda_function(function_name: "test_Lambda") do
    its('function_name') { should eq 'test_Lambda' }
    its('function_arn') { should eq 'arn:aws:lambda:us-east-2:112758395563:function:test_Lambda' }
    its('runtime') { should eq 'python3.7' }
    its('role') { should eq 'arn:aws:iam::112758395563:role/aws-iam-role-bsqfbelcujbbpeahrnunhngxp' }
    its('handler') { should eq 'main.on_event' }
    its('code_size') { should eq 422 }
    its('description') { should eq 'Test Lambda' }
    its('timeout') { should eq 10 }
    its('memory_size') { should eq 128 }
    # its('last_modified') { should_not be_empty }
    its('code_sha_256') { should eq 'WeXkUII6OO08dCVZ6gczLZW51uqN3fCcEO+cjTHKWU0=' }
    its('version') { should eq '$LATEST' }
    its('vpc_config') { should be_empty }
    its('dead_letter_config') { should be_empty }
    its('environment') { should be_empty }
    its('kms_key_arn') { should be_empty }
    its('tracing_config.mode') { should eq 'PassThrough' }
    its('master_arn') { should be_empty }
    its('revision_id') { should eq '8f5ba303-b042-4d1b-9a5d-a2ffff58367a' }
    its('layers') { should be_empty }
    its('state') { should eq 'Active' }
    its('state_reason') { should be_empty }
    its('state_reason_code') { should be_empty }
    its('last_update_status') { should eq 'Successful' }
    its('last_update_status_reason') { should be_empty }
    its('last_update_status_reason_code') { should be_empty }
    its('file_system_configs') { should be_empty }
    its('package_type') { should eq 'Zip' }
    its('image_config_response') { should be_empty }
    its('signing_profile_version_arn') { should be_empty }
    its('signing_job_arn') { should be_empty }
  end
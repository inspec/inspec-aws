describe aws_elasticsearchservice_domain(domain_name: 'test1') do
    it { should exist }
  end
  
  describe aws_elasticsearchservice_domain(domain_name: 'test1') do
      its('domain_id') { should eq '112758395563/test1' }
      its('domain_name') { should eq 'test1' }
      its('arn') { should eq 'arn:aws:es:us-east-2:112758395563:domain/test1' }
      its('created') { should eq true }
      its('deleted') { should eq false }
      its('endpoint') { should_not be_empty }
      its('endpoints') { should be_empty }
      its('processing') { should eq false }
      its('upgrade_processing') { should eq false }
      its('elasticsearch_version') { should eq '7.10' }
  
      its('elasticsearch_cluster_config.instance_type') { should eq 'r6g.large.elasticsearch' }
      its('elasticsearch_cluster_config.instance_count') { should eq 1 }
      its('elasticsearch_cluster_config.dedicated_master_enabled') { should eq false }
      its('elasticsearch_cluster_config.zone_awareness_enabled') { should eq false }
      its('elasticsearch_cluster_config.zone_awareness_config.availability_zone_count') { should be_empty }
      its('elasticsearch_cluster_config.dedicated_master_type') { should be_empty }
      its('elasticsearch_cluster_config.dedicated_master_count') { should be_empty }
      its('elasticsearch_cluster_config.warm_enabled') { should eq false }
      its('elasticsearch_cluster_config.warm_type') { should be_empty }
      its('elasticsearch_cluster_config.warm_count') { should be_empty }
  
      its('ebs_options.ebs_enabled') { should eq true }
      its('ebs_options.volume_type') { should eq 'gp2' }
      its('ebs_options.volume_size') { should eq 10 }
      its('ebs_options.iops') { should be_empty }
  
      # its('access_policies') { should eq '{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"*\"},\"Act...s-east-2:112758395563:domain/test1/*\",\"Condition\":{\"IpAddress\":{\"aws:SourceIp\":\"test\"}}}]}' }
  
      # its('snapshot_options.automated_snapshot_start_hour') { should be_empty }
      its('vpc_options.vpc_id') { should be_empty }
      its('vpc_options.subnet_ids') { should be_empty }
      its('vpc_options.availability_zones') { should be_empty }
      its('vpc_options.availability_zones[0]') { should be_empty }
      its('vpc_options.security_group_ids') { should be_empty }
  
      its('cognito_options.enabled') { should eq false }
      its('cognito_options.user_pool_id') { should be_empty }
      its('cognito_options.identity_pool_id') { should be_empty }
      its('cognito_options.role_arn') { should be_empty }
  
      its('encryption_at_rest_options.enabled') { should eq true }
      its('encryption_at_rest_options.kms_key_id') { should eq 'arn:aws:kms:us-east-2:112758395563:key/ede3e7a6-b765-4c93-8a06-b122d1d7df3f' }
      its('node_to_node_encryption_options.enabled') { should eq true }
  
      # its('advanced_options') { should_not be_empty }
      its('log_publishing_options') { should be_empty }
      
      its('service_software_options.current_version') { should eq 'R20210426' }
      its('service_software_options.new_version') { should eq '' }
      its('service_software_options.update_available') { should eq false }
      its('service_software_options.cancellable') { should eq false }
      its('service_software_options.update_status') { should eq 'COMPLETED' }
      its('service_software_options.description') { should eq 'There is no software update available for this domain.' }
      # its('service_software_options.automated_update_date') { should eq '' }
      its('service_software_options.optional_deployment') { should eq true }
  
      its('domain_endpoint_options.enforce_https') { should eq true }
      its('domain_endpoint_options.tls_security_policy') { should eq 'Policy-Min-TLS-1-0-2019-07' }
      its('domain_endpoint_options.custom_endpoint_enabled') { should eq false }
      its('domain_endpoint_options.custom_endpoint') { should be_empty }
      its('domain_endpoint_options.custom_endpoint_certificate_arn') { should be_empty }
  
      its('advanced_security_options.enabled') { should eq false }
      its('advanced_security_options.internal_user_database_enabled') { should eq false }
      its('advanced_security_options.saml_options.enabled') { should be_empty }
      its('advanced_security_options.saml_options.idp.metadata_content') { should be_empty }
      its('advanced_security_options.saml_options.idp.entity_id') { should be_empty }
      its('advanced_security_options.saml_options.subject_key') { should be_empty }
      its('advanced_security_options.saml_options.roles_key') { should be_empty }
      its('advanced_security_options.saml_options.session_timeout_minutes') { should be_empty }
  end
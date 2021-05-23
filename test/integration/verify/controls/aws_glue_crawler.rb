describe aws_glue_crawler(name: 'test1') do
    it { should exist }
  end
  
  describe aws_glue_crawler(name: 'test1') do
    its('name') { should eq 'test1' }
    its('role') { should eq 'platform-crawler' }
  
    # its('targets.s3_targets') { should be_empty }
    # its('targets.s3_targets.first.path') { should be_empty}
    # its('targets.s3_targets.first.exclusions') { should be_empty }
    # its('targets.s3_targets.first.connection_name') { should be_empty }
  
    # its('targets.jdbc_targets') { should be_empty }
    # its('targets.jdbc_targets.first.connection_name') { should be_empty }
    # its('targets.jdbc_targets.first.path') { should be_empty }
    # its('targets.jdbc_targets.first.exclusions') { should be_empty }
  
    # its('targets.mongo_db_targets') { should be_empty }
    # its('targets.mongo_db_targets.first.connection_name') { should be_empty }
    # its('targets.mongo_db_targets.first.path') { should be_empty }
    # its('targets.mongo_db_targets.first.scan_all') { should be_empty }
  
    # its('targets.dynamo_db_targets') { should be_empty }
    # its('targets.dynamo_db_targets.first.path') { should be_empty }
    # its('targets.dynamo_db_targets.first.scan_all') { should be_empty }
    # its('targets.dynamo_db_targets.first.scan_rate') { should be_empty }
  
    its('targets.catalog_targets') { should_not be_empty }
    its('targets.catalog_targets.first.database_name') { should eq 'sampledb' }
    its('targets.catalog_targets.first.tables') { should include 'elb_logs' }
  
    its('database_name') { should be_empty }
    its('description') { should be_empty }
    its('classifiers ') { should be_empty }
  
    its('recrawl_policy.recrawl_behavior') { should eq 'CRAWL_EVERYTHING' }
  
    its('schema_change_policy.update_behavior') { should eq 'UPDATE_IN_DATABASE' }
    its('schema_change_policy.delete_behavior') { should eq 'LOG' }
  
    its('state') { should eq 'READY' }
    its('table_prefix') { should be_empty }
  
    its('schedule.schedule_expression') { should be_empty }
    its('schedule.state') { should be_empty }
  
    # its('crawl_elapsed_time') { should_not be_empty }
    # its('creation_time') { should_not be_empty }
    # its('last_updated') { should_not be_empty }
  
    its('last_crawl.status') { should eq 'SUCCEEDED' }
    its('last_crawl.error_message') { should be_empty }
    its('last_crawl.log_group') { should eq '/aws-glue/crawlers' }
    its('last_crawl.log_stream') { should eq 'test1' }
    its('last_crawl.message_prefix') { should eq 'e8eeb54a-86bb-4c72-8fb9-3e98db0c19ba' }
    # its('last_crawl.start_time') { should_not be_empty }
  
    its('version') { should eq 1 }
    its('configuration') { should_not be_empty }
    its('crawler_security_configuration') { should be_empty }
  end
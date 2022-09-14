aws_crawler_name = input(:aws_crawler_name, value: '', description: '')

control 'aws-glue-crawler-1.0' do
  impact 1.0
  title 'Ensure AWS Glue Crawler has the correct properties.'

  describe aws_glue_crawler(name: aws_crawler_name) do
    it { should exist }
  end

  describe aws_glue_crawler(name: aws_crawler_name) do
    its('name') { should eq aws_crawler_name }
    its('role') { should eq 'platform-crawler' }
    its('targets.catalog_targets') { should_not be_empty }
    its('targets.catalog_targets.first.database_name') { should eq 'sampledb2' }
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

    its('last_crawl.status') { should eq 'SUCCEEDED' }
    its('last_crawl.error_message') { should be_empty }
    its('last_crawl.log_group') { should eq '/aws-glue/crawlers' }
    its('last_crawl.log_stream') { should eq 'test1' }
    its('last_crawl.message_prefix') { should eq 'e8eeb54a-86bb-4c72-8fb9-3e98db0c19ba' }

    its('version') { should eq 1 }
    its('configuration') { should_not be_empty }
    its('crawler_security_configuration') { should be_empty }
  end
end

aws_crawler_name = attribute(:aws_crawler_name, value: 'test1', description: '')

control 'aws-glue-crawlers-1.0' do
  impact 1.0
  title 'Ensure AWS Glue Crawlers has the correct properties.'

  describe aws_glue_crawlers do
    it { should exist }
  end
  
  describe aws_glue_crawlers do
    its('names') { should include aws_crawler_name }
  end
end
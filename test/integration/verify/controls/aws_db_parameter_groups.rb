title 'Test AWS RDS Parameter Groups in bulk'

control 'aws-db-parameter-groups-1.0' do

  impact 1.0
  title 'Ensure AWS RDS Parameter groups has current properties'

  describe aws_db_parameter_groups do
    it { should exist }
  end

end
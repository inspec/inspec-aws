title 'Test AWS RDS Subnet Groups in bulk'

control 'aws-db-subnet-groups-1.0' do
  title 'Ensure AWS RDS Subnet groups has current properties'

  describe aws_db_subnet_groups do
    it { should exist }
  end
end

aws_rds_db_identifier = input(:aws_rds_db_identifier, value: '', description: 'The AWS RDS DB identifier.')

title 'Test multiple AWS RDS instances'

control 'aws-rds-instances-1.0' do
  impact 1.0
  title 'Ensure AWS RDS Instances has the correct properties.'

  describe aws_rds_instances do
    it { should exist }
  end

  aws_rds_instances.where(db_instance_identifier: aws_rds_db_identifier).db_instance_identifiers.each do |db_instance_identifier|
    describe aws_rds_instance(db_instance_identifier) do
      it { should have_encrypted_storage }
      it { should be_encrypted }
    end
  end
end

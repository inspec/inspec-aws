aws_redshift_db_identifier = input(:aws_redshift_cluster_identifier, value: '', description: 'The AWS Reddhift DB identifier.')

control 'aws_redshift_cluster-1.0' do
  title 'Ensure AWS redshift cluster has the correct properties.'

  describe aws_redshift_cluster(cluster_identifier: aws_redshift_db_identifier) do
    it { should exist }
    its ('node_type') { should eq 'dc2.large' }
    its ('cluster_status') { should eq 'available'  }
    its ('cluster_availability_status') { should eq 'Available' }
    its ('master_username') { should eq 'testcluster' }
    its ('db_name') { should eq 'dev' }
    its ('vpc_id') { should eq 'vpc-6d9d7505' }
    its ('cluster_availability_status') { should eq 'Available' }
    its ('cluster_subnet_group_name') { should eq 'default' }
    its ('allow_version_upgrade') { should eq true }
    its ('encrypted') { should eq false }
  end
end




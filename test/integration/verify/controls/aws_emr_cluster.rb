aws_emr_cluster_id = attribute(:aws_emr_cluster_id, value: '', description: 'AWS EMR cluster ID.')
aws_emr_cluster_service_role = attribute(:aws_emr_cluster_service_role, value: '', description: 'AWS EMR cluster Service Role.')
aws_emr_cluster_applications = attribute(:aws_emr_cluster_applications, value: '', description: 'IAM role that will be assumed by the Amazon EMR service to access AWS resources on your behalf.')
aws_emr_cluster_arn = attribute(:aws_emr_cluster_arn, value: '', description: 'ARN of the cluster.')
aws_emr_cluster_name = attribute(:aws_emr_cluster_name, value: '', description: 'Name of the cluster.')
aws_emr_cluster_visible_to_all_users = attribute(:aws_emr_cluster_visible_to_all_users, value: '', description: 'Indicates whether the job flow is visible to all IAM users of the AWS account associated with the job flow.')
aws_emr_cluster_visible_to_all_users = (aws_emr_cluster_visible_to_all_users.downcase == 'true')
aws_emr_cluster_release_label = attribute(:aws_emr_cluster_release_label, value: '', description: 'Release label for the Amazon EMR release.')

control 'aws-emr-cluster-1.0' do
  impact 1.0
  title 'Test single AWS EMR Cluster'

  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    it { should exist }
  end

  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    it { should_not be_running }
  end
  
  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    it { should be_waiting }
  end

  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    its('applications') { should include 'Spark' }
  end

  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    its('service_role') { should eq aws_emr_cluster_service_role }
  end

  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    its('cluster_arn') { should eq aws_emr_cluster_arn }
  end

  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    its('cluster_name') { should eq aws_emr_cluster_name }
  end

  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    its('visible_to_all_users') { should eq aws_emr_cluster_visible_to_all_users }
  end

  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    its('release_label') { should eq aws_emr_cluster_release_label }
  end
end

aws_emr_cluster_id = input(:aws_emr_cluster_id, value: '', description: 'AWS EMR cluster ID.')
aws_emr_cluster_id.gsub!('"', '')
aws_emr_cluster_service_role = input(:aws_emr_cluster_service_role, value: '', description: 'AWS EMR cluster Service Role.')
aws_emr_cluster_service_role.gsub!('"', '')
aws_emr_cluster_applications = input(:aws_emr_cluster_applications, value: '', description: 'IAM role that will be assumed by the Amazon EMR service to access AWS resources on your behalf.')
aws_emr_cluster_arn = input(:aws_emr_cluster_arn, value: '', description: 'ARN of the cluster.')
aws_emr_cluster_name = input(:aws_emr_cluster_name, value: '', description: 'Name of the cluster.')
aws_emr_cluster_visible_to_all_users = input(:aws_emr_cluster_visible_to_all_users, value: '', description: 'Indicates whether the job flow is visible to all IAM users of the AWS account associated with the job flow.')
aws_emr_cluster_visible_to_all_users = (aws_emr_cluster_visible_to_all_users.downcase == 'true')
aws_emr_cluster_release_label = input(:aws_emr_cluster_release_label, value: '', description: 'Release label for the Amazon EMR release.')

control 'aws-emr-cluster-1.0' do
  title 'Test single AWS EMR Cluster'

  describe aws_emr_cluster(cluster_id: aws_emr_cluster_id) do
    it { should exist }
    it { should_not be_running }
    it { should be_waiting }
    its('application_names') { should include 'Spark' }
    its('service_role') { should eq aws_emr_cluster_service_role }
    its('cluster_arn') { should eq aws_emr_cluster_arn }
    its('cluster_name') { should eq aws_emr_cluster_name }
    its('visible_to_all_users') { should eq aws_emr_cluster_visible_to_all_users }
    its('release_label') { should eq aws_emr_cluster_release_label }
  end
end

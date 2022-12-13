title 'Test single AWS EFS File System'

aws_efs_encrypted = input(:aws_efs_encrypted, value: '', description: 'The EFS encryption state.')
aws_efs_performance_mode = input(:aws_efs_performance_mode, value: '', description: 'The EFS performance mode.')
aws_efs_throughput_mode = input(:aws_efs_throughput_mode, value: '', description: 'The EFS throughput mode.')
aws_efs_company_name = input(:aws_efs_company_name, value: '', description: 'The EFS File System company name tag.')
aws_efs_count = input(:aws_efs_count, value: '', description: 'The number of EFS File Systems.')

control 'aws-efs-file-systems-1.0' do
  title 'Ensure AWS EFS File System plural resource has the correct properties.'

  describe aws_efs_file_systems do
    its('count') { should be >= aws_efs_count }
  end

  # Iterate through all file systems
  aws_efs_file_systems.file_system_ids.each do |file_system_id|
    describe aws_efs_file_system(file_system_id) do
      its('tags') { should include('companyName' => aws_efs_company_name) }
      it { should be_encrypted } if aws_efs_encrypted
      its('throughput_mode') { should eq aws_efs_throughput_mode }
      its('performance_mode') { should eq aws_efs_performance_mode }
    end
  end
end

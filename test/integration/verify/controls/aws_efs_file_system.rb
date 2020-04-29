title "Test single AWS EFS File System"

aws_efs_creation_token = attribute(:aws_efs_creation_token, value: "", description: "The EFS File System identifier.")
aws_efs_encrypted = attribute(:aws_efs_encrypted, value: "", description: "The EFS encryption state.")
aws_efs_performance_mode = attribute(:aws_efs_performance_mode, value: "", description: "The EFS performance mode.")
aws_efs_throughput_mode = attribute(:aws_efs_throughput_mode, value: "", description: "The EFS throughput mode.")
aws_efs_name = attribute(:aws_efs_name, value: "", description: "The EFS File System name.")

control "aws-efs-file-system-1.0" do

  impact 1.0
  title "Check AWS EFS File System has the correct properties."

  describe aws_efs_file_system(creation_token: aws_efs_creation_token) do
    it { should exist }
    it { should be_encrypted } if aws_efs_encrypted
    its("size_in_bytes.value") { should be > 1 }
    its("throughput_mode") { should eq aws_efs_throughput_mode }
    its("tags") { should include("Name" => aws_efs_name) }
    its("performance_mode") { should eq aws_efs_performance_mode }
  end
end

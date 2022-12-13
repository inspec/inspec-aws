aws_ecr_repository_name = input(:aws_ecr_repository_name, value: '', description: 'The ECR repository identifier.')
aws_ecr_repository_image_tag_mutability = input(:aws_ecr_repository_image_tag_mutability, value: '', description: \
'The ECR repository image tag mutability status. (MUTABLE/IMMUTABLE)')
aws_ecr_repository_scan_on_push_enabled = input(:aws_ecr_repository_scan_on_push_enabled, value: '', description: \
'The ECR repository scan on push status. (true/false)')

title 'Test single AWS ECR Repository'

control 'aws-ecr-repository-1.0' do
  title 'Check AWS ECR repository has the correct properties.'

  describe aws_ecr_repository(repository_name: aws_ecr_repository_name) do
    it { should exist }
    its('image_tag_mutability') { should eq aws_ecr_repository_image_tag_mutability }
    its('image_scanning_configuration.scan_on_push') { should eq aws_ecr_repository_scan_on_push_enabled }
    its('tags') { should include('Name' => aws_ecr_repository_name) }
  end

  describe aws_ecr_repository('not-there') do
    it { should_not exist }
  end
end

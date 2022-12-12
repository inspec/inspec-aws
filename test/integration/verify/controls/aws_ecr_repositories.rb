aws_ecr_repository_name = input(:aws_ecr_repository_name, value: '', description: 'The ECR repository identifier.')
aws_ecr_repository_image_tag_mutability = input(:aws_ecr_repository_image_tag_mutability, value: '', description: \
'The ECR repository image tag mutability status. (MUTABLE/IMMUTABLE)')
aws_ecr_repository_scan_on_push_enabled = input(:aws_ecr_repository_scan_on_push_enabled, value: '', description: \
'The ECR repository scan on push status. (true/false)')

title 'Test multiple AWS ECR Repositories'

control 'aws-ecr-repositories-1.0' do
  title 'Check AWS ECR repositories has the correct properties.'

  describe aws_ecr_repositories do
    it { should exist }
    its('count') { should be >= 1 }
  end

  describe aws_ecr_repositories.where(name: aws_ecr_repository_name) do
    it { should exist }
    # where clause returns a list, hence, include is used.
    its('image_tag_mutability_status') { should include aws_ecr_repository_image_tag_mutability }
    its('image_scanning_on_push_status') { should include aws_ecr_repository_scan_on_push_enabled }
  end
end

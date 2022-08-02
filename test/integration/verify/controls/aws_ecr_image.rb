aws_ecr_repository_name = input(:aws_ecr_repository_name, value: '', description: 'The ECR repository identifier.')

title 'Test single AWS ECR Image in a repository'

control 'aws-ecr-image-1.0' do
  impact 1.0
  title 'Check AWS ECR image has the correct properties.'

  describe aws_ecr_image(repository_name: aws_ecr_repository_name, image_tag: 'latest') do
    it { should_not exist }
  end
end

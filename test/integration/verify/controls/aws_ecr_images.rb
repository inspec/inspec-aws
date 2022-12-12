aws_ecr_repository_name = input(:aws_ecr_repository_name, value: '', description: 'The ECR repository identifier.')

title 'Test Multiple AWS ECR Images in a Repository'

control 'aws-ecr-images-1.0' do
  title 'Check AWS ECR images has the correct properties.'

  describe aws_ecr_images(repository_name: aws_ecr_repository_name) do
    it { should_not exist }
  end
end

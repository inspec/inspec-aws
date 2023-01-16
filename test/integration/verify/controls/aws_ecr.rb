title 'Test single AWS ECR'

aws_ecr_name = input(:aws_ecr_name, value: '', description: 'The AWS ECR name.')

control 'aws-ecr-1.0' do
  title 'Ensure AWS ECR has the correct properties.'

  describe aws_ecr(repository_name: aws_ecr_name) do
    it                       { should exist }
    its ('repository_name')  { should eq aws_ecr_name }
  end
end

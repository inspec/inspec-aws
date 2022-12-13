title 'Test ECR repository Policy'
 
aws_ecr_repo_name = input(:aws_ecr_repo_name, value: '', description: 'The ECR repositiory name.')
aws_iam_user_policy_name = input(:aws_iam_user_policy_name, value: '', description: 'The AWS Iam User Inline Policy.')

control 'aws-ecr-repo-policy-1.0' do
  title 'Ensure ECR repo Policy has the correct properties.'
 
  describe aws_ecr_repository_policy(aws_ecr_repo_name) do
    it           { should exist }
    it { should have_statement(Action: "ecr:GetDownloadUrlForLayer", Effect: "Allow", Principal: "*", Sid: "new policy")}
  end  
end

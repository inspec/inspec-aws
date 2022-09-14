aws_ecrpublic_repository_name = input(:aws_ecrpublic_repository_name, value: '', description: 'The ECR public repository identifier.')

title 'Test single AWS ECR public Repository'

control 'aws-ecrpublic-repository-1.0' do
  impact 1.0
  title 'Check AWS ECR public repository has the correct properties.'

  describe aws_ecrpublic_repository(repository_name: aws_ecrpublic_repository_name) do
    it { should exist }
  end

  describe aws_ecrpublic_repository(repository_name: 'not-there') do
    it { should_not exist }
  end
end
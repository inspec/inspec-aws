aws_ecrpublic_repository_name = input(:aws_ecrpublic_repository_name, value: '', description: 'The ECR public repository identifier.')

title 'Test multiple AWS ECR public Repositories'

control 'aws-ecrpublic-repositories-1.0' do
  impact 1.0
  title 'Check AWS ECR public repositories has the correct properties.'

  describe aws_ecrpublic_repositories do
    it { should exist }
    its('count') { should be >= 1 }
  end

  describe aws_ecrpublic_repositories.where(name: aws_ecrpublic_repository_name) do
    it { should exist }
  end
end
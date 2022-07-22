title 'AWS Lambdas compliance Tests'

control 'Check that any lambdas are correctly configured' do
  impact 1.0
  title 'Lambda tests'
  desc 'Ensure that our lambdas are correctly deployed'

  describe aws_lambdas do
    its('count') { should be >= 1 }
  end
end

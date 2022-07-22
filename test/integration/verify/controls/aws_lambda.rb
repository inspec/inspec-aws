title 'AWS Lambda compliance Tests'

control 'Check that lambda is correctly configured' do
  impact 1.0
  title 'Lambda tests'
  desc 'Ensure that our lambda is correctly deployed'

  describe aws_lambda('test_Lambda') do
    it { should exist}    
    its ('handler') { should eq 'main.on_event'}
    its ('version') { should eq '$LATEST' }
    its ('runtime') { should eq 'python3.7' }
  end
end

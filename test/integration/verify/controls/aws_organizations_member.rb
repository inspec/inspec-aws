control 'aws-organizations-member-1.0' do
  impact 1.0
  title 'Ensure the current AWS Account is not the Master Account'

  describe aws_organizations_member do
    it { should exist }
    it { should_not be_master }
  end
end

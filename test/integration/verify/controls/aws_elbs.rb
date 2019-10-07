title 'Test a collection of AWS ELBs'

aws_elb_name = attribute(:aws_elb_name, default: '', description: 'The AWS ELB name.')

control 'aws-elbs-1.0' do

  impact 1.0
  title 'Ensure AWS ELBs have the correct properties.'

  describe aws_elbs do
    it                          { should exist }
    its ('load_balancer_names') { should include aws_elb_name }
  end
end
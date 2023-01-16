title 'Test a collection of AWS ELBs'

aws_elb_name = input(:aws_elb_name, value: '', description: 'The AWS ELB name.')

control 'aws-elbs-1.0' do
  title 'Ensure AWS ELBs have the correct properties.'

  describe aws_elbs do
    it                          { should exist }
    its ('load_balancer_names') { should include aws_elb_name }
  end
end

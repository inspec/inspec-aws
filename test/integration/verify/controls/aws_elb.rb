title 'Test single AWS ELB'

aws_elb_name = attribute(:aws_elb_name, default: '', description: 'The AWS ELB name.')

control 'aws-elb-1.0' do

  impact 1.0
  title 'Ensure AWS ELB has the correct properties.'

  describe aws_elb(load_balancer_name: aws_elb_name) do
    it                          { should exist }
    its ('load_balancer_name')  { should eq aws_elb_name }
  end
end
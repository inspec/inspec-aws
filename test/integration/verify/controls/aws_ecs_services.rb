control 'aws-ecs-services-1.0' do
    impact 1.0
    title 'Ensure AWS ECS Services has the correct properties.'
    describe aws_ecs_services(cluster: "test1") do
      it { should exist }
    end
end
  
control 'aws-ecs-services-1.0' do
  impact 1.0
  title 'Ensure AWS ECS Services has the correct properties.'
  describe aws_ecs_services(cluster: "test1") do
    its('service_arns') { should include ["arn:aws:ecs:us-east-2:112758395563:service/test1/test1", "arn:aws:ecs:us-east-2:112758395563:service/test1/service2"] }
  end
end
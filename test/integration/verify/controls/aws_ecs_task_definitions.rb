control 'aws-ec2-task-definitions-1.0' do
  impact 1.0
  title 'Ensure EC2 Task Definitions has the correct properties.'
  
  describe aws_ecs_task_definitions do
    it { should exist }
  end
  
  describe aws_ecs_task_definitions do
    its('task_definition_arns') { should_not include ['arn1', 'arn2'] }
  end
  
  describe aws_ecs_task_definitions do
    its('task_definition_arns') { should_not include 'dummy' }
  end
end
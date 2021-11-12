control 'aws-ec2-task-definitions1-1.0' do

    impact 1.0
    title 'Ensure EC2 Task Definitions has the correct properties.'
  
    describe aws_ecs_task_definitions do
        it { should exist }
    end
end

control 'aws-ec2-task-definitions2-1.0' do

    impact 1.0
    title 'Ensure EC2 Task Definitions has the correct properties.'
  
    describe aws_ecs_task_definitions do
        its("task_definition_arns") { should_not include ["arn1", "arn2"] }
    end
end


control 'aws-ec2-task-definitions3-1.0' do

    impact 1.0
    title 'Ensure EC2 Task Definitions has the correct properties.'
  
    describe aws_ecs_task_definitions do
        its("task_definition_arns") { should_not include 'dummy' }
    end
end
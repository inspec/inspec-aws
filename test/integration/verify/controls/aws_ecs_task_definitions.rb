describe aws_ecs_task_definitions do
    it { should exist }
end

describe aws_ecs_task_definitions do
    its("task_definition_arns") { should include ["arn:aws:ecs:us-east-2:112758395563:task-definition/test1:1", "arn:aws:ecs:us-east-2:112758395563:task-definition/test1:2"] }
end

describe aws_ecs_task_definitions do
    its("task_definition_arns") { should_not include 'dummy' }
end
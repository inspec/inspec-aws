aws_service_namespace = attribute("aws_service_namespace", default: "ec2", description: "")

describe aws_application_autocaling_scaling_policy(service_namespace: aws_service_namespace) do
  it { should exist }
end
aws_service_namespace = attribute("aws_service_namespace", default: "ec2", description: "")

describe aws_application_autoscaling_scalable_target(service_namespace: aws_service_namespace) do
  it { should exist }
end
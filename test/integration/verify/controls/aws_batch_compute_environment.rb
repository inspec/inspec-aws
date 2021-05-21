aws_compute_environment_name = attribute("aws_compute_environment_name", default: "", description: "")
aws_compute_environment_arn = attribute("aws_compute_environment_arn", default: "", description: "")
aws_ecs_cluster_arn = attribute("aws_ecs_cluster_arn", default: "", description: "")
aws_tags = attribute("aws_tags", default: "", description: "")
aws_type = attribute("aws_type", default: "", description: "")
aws_state = attribute("aws_state", default: "", description: "")
aws_status = attribute("aws_status", default: "", description: "")
aws_status_reason = attribute("aws_status_reason", default: "", description: "")
aws_service_role = attribute("aws_service_role", default: "", description: "")
aws_compute_resources_type = attribute("aws_compute_resources_type", default: "", description: "")
aws_compute_resources_allocation_strategy = attribute("aws_compute_resources_allocation_strategy", default: "", description: "")
aws_compute_resources_minv_cpus = attribute("aws_compute_resources_minv_cpus", default: "", description: "")
aws_compute_resources_maxv_cpus = attribute("aws_compute_resources_maxv_cpus", default: "", description: "")
aws_compute_resources_desiredv_cpus = attribute("aws_compute_resources_desiredv_cpus", default: "", description: "")
aws_compute_resources_instance_types = attribute("aws_compute_resources_instance_types", default: "", description: "")
aws_compute_resources_image_id = attribute("aws_compute_resources_image_id", default: "", description: "")
aws_compute_resources_subnets = attribute("aws_compute_resources_subnets", default: "", description: "")
aws_compute_resources_security_group_ids = attribute("aws_compute_resources_security_group_ids", default: "", description: "")
aws_compute_resources_ec2_key_pair = attribute("aws_compute_resources_ec2_key_pair", default: "", description: "")
aws_compute_resources_instance_role = attribute("aws_compute_resources_instance_role", default: "", description: "")
aws_compute_resources_tags = attribute("aws_compute_resources_tags", default: "", description: "")
aws_compute_resources_placement_group = attribute("aws_compute_resources_placement_group", default: "", description: "")
aws_compute_resources_bid_percentage = attribute("aws_compute_resources_bid_percentage", default: "", description: "")
aws_compute_resources_spot_iam_fleet_role = attribute("aws_compute_resources_spot_iam_fleet_role", default: "", description: "")
aws_compute_resources_launch_template = attribute("aws_compute_resources_launch_template", default: "", description: "")
aws_compute_resources_ec2_configuration = attribute("aws_compute_resources_ec2_configuration", default: "", description: "")

describe aws_batch_compute_environment(compute_environment_name: aws_compute_environment_name) do
  it { should exist }
  its('compute_environment_name') { should eq aws_compute_environment_name }
  its('compute_environment_arn') { should eq aws_compute_environment_arn }
  its('ecs_cluster_arn') { should eq aws_ecs_cluster_arn }
  its('tags') { should be_empty  }
  its('type') { should eq aws_type }
  its('state') { should eq aws_state }
  its('status') { should eq aws_status }
  its('status_reason') { should eq aws_status_reason }
  its('service_role') { should eq aws_service_role }
  its('compute_resources.type') { should eq aws_compute_resources_type }
  its('compute_resources.allocation_strategy') { should be_empty }
  its('compute_resources.minv_cpus') { should be_empty  }
  its('compute_resources.maxv_cpus') { should eq aws_compute_resources_maxv_cpus }
  its('compute_resources.desiredv_cpus') { should be_empty }
  its('compute_resources.instance_types') { should be_empty }
  its('compute_resources.image_id') { should be_empty }
  its('compute_resources.subnets') { should include aws_compute_resources_subnets }
  its('compute_resources.security_group_ids') { should include aws_compute_resources_security_group_ids }
  its('compute_resources.ec2_key_pair') { should be_empty }
  its('compute_resources.instance_role') { should be_empty }
  its('compute_resources.tags') { should be_empty }
  its('compute_resources.placement_group') { should be_empty }
  its('compute_resources.bid_percentage') { should be_empty }
  its('compute_resources.spot_iam_fleet_role') { should be_empty }
  its('compute_resources.launch_template.launch_template_id') { should be_empty }
  its('compute_resources.launch_template.launch_template_name') { should be_empty }
  its('compute_resources.launch_template.version') { should be_empty }
end
aws_compute_environment_name = attribute("aws_compute_environment_name", value: "", description: "")
aws_state = attribute("aws_batch_job_queue_status", value: "", description: "")
aws_compute_resources_type = attribute("aws_type", value: "", description: "")
aws_compute_resources_minv_cpus = attribute("aws_min_vcpus", value: "", description: "")
aws_compute_resources_maxv_cpus = attribute("aws_max_vcpus", value: "", description: "")

describe aws_batch_compute_environments do
  it { should exist }
  its('compute_environment_names') { should include aws_compute_environment_name }
  its('types') { should include "MANAGED" }
  its('states') { should include aws_state }
  its('statuses') { should include "VALID" }
  its('status_reasons') { should include  "ComputeEnvironment Healthy"}
  its('compute_resources.allocation_strategys') { should be_empty }
  its('compute_resources.minv_cpus') { should be <= aws_compute_resources_minv_cpus  }
  its('compute_resources.maxv_cpus') { should be <= aws_compute_resources_maxv_cpus }

end
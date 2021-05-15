aws_user_pool_id = attribute("aws_user_pool_id", default: "us-east-2_LNINsLQZz", description: "")
aws_client_id = attribute("aws_client_id", default: "riviih58bb3grs0itqa67d3hp", description: "")
aws_client_name = attribute("aws_client_name", default: "test1", description: "")


describe aws_cognito_userpool_clients(user_pool_id: aws_user_pool_id) do
  it { should exist }
end

describe aws_cognito_userpool_clients(user_pool_id: aws_user_pool_id) do
  its('user_pool_ids') { should include aws_user_pool_id }
  its('client_ids') { should include aws_client_id }
  its('client_names') { should include aws_client_name }
end
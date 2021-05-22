describe aws_secretsmanager_secret(secret_id: "value") do
    it { should exist }
end

describe aws_secretsmanager_secret(secret_id: "value") do
    its("arn") { should eq "test" }
    its("name") { should eq "test" }
    its("description") { should eq "test" }
    its("kms_key_id") { should eq "test" }
    its("rotation_enabled") { should eq true }
    its("rotation_lambda_arn") { should eq "test" }
    its("rotation_rules.automatically_after_days") { should eq 1 }
    its("last_rotated_date") { should eq "test" }
    its("last_changed_date") { should eq "test" }
    its("last_accessed_date") { should eq "test" }
    its("deleted_date") { should eq "test" }
    its("tags") { should eq "test" }
    its("owning_service") { should eq "test" }
    its("created_date") { should eq "test" }
end
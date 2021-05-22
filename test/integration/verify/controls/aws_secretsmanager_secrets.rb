describe aws_secretsmanager_secrets do
    it { should exist }
end

describe aws_secretsmanager_secrets do
    its("arns") { should include "test" }
    its("names") { should include "test" }
    its("descriptions") { should include "test" }
    its("kms_key_ids") { should include "test" }
    its("rotation_enableds") { should include true }
    its("rotation_lambda_arns") { should include "test" }
    its("rotation_rules") { should include 1 }
    its("last_rotated_dates") { should include "test" }
    its("last_changed_dates") { should include "test" }
    its("last_accessed_dates") { should include "test" }
    its("deleted_dates") { should include "test" }
    its("tags") { should include "test" }
    its("owning_services") { should include "test" }
    its("created_dates") { should include "test" }
end
describe aws_dms_endpoints do
    it { should exist }
end

describe aws_dms_endpoints do
    its('endpoint_identifiers') { should include "database-1" }
    its('endpoint_types') { should include "SOURCE" }
    its('engine_names') { should include "postgres" }
    its('engine_display_names') { should include "PostgreSQL" }
    its('ports') { should include 5432 }
end
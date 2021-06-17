control 'aws-ram-resource-shares-1.0' do
    impact 1.0
    title 'Describes the resource shares of the ram.'

    describe aws_ram_resource_shares(resource_owner: "SELF") do
        it { should exist }
    end

    describe aws_ram_resource_shares(resource_owner: "SELF") do
        its("arns") { should include "arn:aws:ec2:us-east-2:112758395563:subnet/subnet-07e5cc100d2f2f137" }
        its("types") { should include "ec2:Subnet" }
        its("resource_share_arns") { should include "arn:aws:ram:us-east-2:112758395563:resource-share/76970b3f-97cf-4dd2-934f-76fc2b43a8e0" }
        its("resource_group_arns") { should_not be_empty }
        its("statuses") { should_not be_empty }
        its("status_messages") { should_not be_empty }
        its("creation_times") { should_not be_empty }
        its("last_updated_times") { should_not be_empty }
    end
end
# Copyright: 2018, The Authors

title "Sample Section"

# Plural resources can be inspected to check for specific resource details
control "aws-vpcs-multi-region-status-check" do                             # A unique ID for this control.
  impact 1.0                                                                # The criticality, if this control fails.
  title 'Check AWS VPCs in all regions have status "available"'             # A human-readable title.
  aws_regions.region_names.each do |region|                                 # Loop over all available AWS regions
    aws_vpcs(aws_region: region).vpc_ids.each do |vpc|                      # Find all VPCs in a single AWS region
      describe aws_vpc(aws_region: region, vpc_id: vpc) do                  # The test itself.
        it { should exist }                                                 # Confirms AWS VPC exists
        it { should be_available }                                          # Confirms AWS VPC has status "available"
      end
    end
  end
end

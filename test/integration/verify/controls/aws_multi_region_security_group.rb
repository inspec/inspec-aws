title 'Test AWS Security Groups Across All Regions'

control 'aws-multi-region-security-group-1.0' do
  title 'Ensure AWS Security Groups across all regions have the correct properties.'

  aws_regions.region_names.each do |region|
    aws_security_groups(aws_region: region).group_ids.each do |security_group_id|
      describe aws_security_group(aws_region: region, group_id: security_group_id) do
        it { should exist }
        it { should_not allow_in_only(port: 12345) }
      end
    end
  end
end

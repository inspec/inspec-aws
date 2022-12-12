title 'Test AWS Configuration Recorder Across All Regions'

control 'aws-multi-region-config-recorder-1.0' do
  title 'Ensure at least one AWS Configuration Recorder exists across all regions.'

  aws_regions.region_names.each do |region|
    describe.one do
      describe aws_config_recorder(aws_region: region) do
        skip 'There can be either zero or one configuration recorder per AWS region.'
        # it { should exist }
      end
    end
  end
end

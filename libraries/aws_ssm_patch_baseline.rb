require 'aws_backend'

class AWSSESPatchBaseline < AwsResourceBase
  name 'aws_ssm_patch_baseline'
  desc 'Retrieves information about a patch baseline.'

  example "
    describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
      it { should exist }
    end

    describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
      its('baseline_id') { should eq 'BASELINE_ID' }
    end

    describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
      its('source_names') { should be_empty }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(baseline_id))
    raise ArgumentError, "#{@__resource_name__}: baseline_id must be provided" unless opts[:baseline_id] && !opts[:baseline_id].empty?
    @display_name = opts[:baseline_id]
    catch_aws_errors do
      resp = @aws.ssm_client.get_patch_baseline({ baseline_id: opts[:baseline_id] })
      @res = resp.to_h
      @baseline_id = @res[:baseline_id]
      @name = @res[:name]
      create_resource_methods(@res)
    end
  end

  def resource_id
    "#{@baseline_id}_#{@name}"
  end

  def baseline_id
    return nil unless exists?
    @res[:baseline_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def patch_filter_keys
    global_filters.map(&:patch_filters).map(&:key)
  end

  def patch_filter_values
    global_filters.map(&:patch_filters).map(&:values)
  end

  def patch_filter_groups
    approval_rules.map(&:patch_rules).map(&:patch_filter_group).map(&:patch_filters)
  end

  def patch_filter_group_keys
    approval_rules.map(&:patch_rules).map(&:patch_filter_group).map(&:patch_filters).map(&:key)
  end

  def patch_filter_group_values
    approval_rules.map(&:patch_rules).map(&:patch_filter_group).map(&:patch_filters).map(&:values)
  end

  def compliance_levels
    approval_rules.map(&:patch_rules).map(&:compliance_level)
  end

  def approve_after_days
    approval_rules.map(&:patch_rules).map(&:approve_after_days)
  end

  def approve_until_dates
    approval_rules.map(&:patch_rules).map(&:approve_until_date)
  end

  def enable_non_securities
    approval_rules.map(&:patch_rules).map(&:enable_non_security)
  end

  def source_names
    sources.map(&:names)
  end

  def source_products
    sources.map(&:products)
  end

  def source_configurations
    sources.map(&:configurations)
  end

  def to_s
    "Baseline Id: #{@display_name}"
  end
end

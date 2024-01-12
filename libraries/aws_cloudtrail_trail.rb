require "aws_backend"

class AwsCloudTrailTrail < AwsResourceBase
  name "aws_cloudtrail_trail"
  desc "Verifies settings for an individual AWS CloudTrail Trail."
  example <<-EXAMPLE
    describe aws_cloudtrail_trail('TRAIL_NAME') do
      it { should exist }
      it { should be_monitoring_read("AWS::S3::Object") }
      it { should be_monitoring_write("AWS::S3::Object") }
      it { should be_multi_region_trail }
    end
  EXAMPLE

  attr_reader :cloud_watch_logs_log_group_arn,
              :cloud_watch_logs_role_arn,
              :home_region,
              :trail_name,
              :kms_key_id,
              :s3_bucket_name,
              :s3_key_prefix,
              :trail_arn,
              :is_multi_region_trail,
              :log_file_validation_enabled,
              :is_organization_trail,
              :event_selectors

  alias multi_region_trail? is_multi_region_trail
  alias log_file_validation_enabled? log_file_validation_enabled
  alias has_log_file_validation_enabled? log_file_validation_enabled
  alias organization_trail? is_organization_trail

  def initialize(opts = {})
    opts = { trail_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:trail_name])

    @trail_name = opts[:trail_name]
    @event_selectors = []
    catch_aws_errors do
      resp =
        @aws.cloudtrail_client.describe_trails(
          { trail_name_list: [@trail_name] },
        )
      @event_selectors = @aws.cloudtrail_client.get_event_selectors({ trail_name: @trail_name })
      @trail = resp.trail_list[0].to_h
      @trail_arn = @trail[:trail_arn]
      @kms_key_id = @trail[:kms_key_id]
      @home_region = @trail[:home_region]
      @s3_bucket_name = @trail[:s3_bucket_name]
      @s3_key_prefix = @trail[:s3_key_prefix]
      @is_organization_trail = @trail[:is_organization_trail]
      @is_multi_region_trail = @trail[:is_multi_region_trail]
      @cloud_watch_logs_role_arn = @trail[:cloud_watch_logs_role_arn]
      @log_file_validation_enabled = @trail[:log_file_validation_enabled]
      @cloud_watch_logs_log_group_arn = @trail[:cloud_watch_logs_log_group_arn]
    end
  end

  def resource_id
    @trail_arn
  end

  def delivered_logs_days_ago
    return nil unless exists?
    catch_aws_errors do
      begin
        trail_status =
          @aws.cloudtrail_client.get_trail_status({ name: @trail_name }).to_h
        unless trail_status[:latest_cloud_watch_logs_delivery_time].nil?
          (
            (Time.now - trail_status[:latest_cloud_watch_logs_delivery_time]) /
              (24 * 60 * 60)
          ).to_i
        end
      rescue Aws::CloudTrail::Errors::TrailNotFoundException
        nil
      end
    end
  end

  def logging?
    catch_aws_errors do
      begin
        @aws.cloudtrail_client.get_trail_status({ name: @trail_name }).to_h[
          :is_logging
        ]
      rescue Aws::CloudTrail::Errors::TrailNotFoundException
        nil
      end
    end
  end

  def encrypted?
    !@kms_key_id.nil?
  end

  def get_log_group_for_multi_region_active_mgmt_rw_all
    return nil unless exists?
    return nil unless @cloud_watch_logs_log_group_arn
    return nil if @cloud_watch_logs_log_group_arn.split(":").count < 6
    if has_event_selector_mgmt_events_rw_type_all? && logging?
      @cloud_watch_logs_log_group_arn.split(":")[6]
    end
  end

  # TODO: see what happens when running against nil event selectors
  def has_event_selector_mgmt_events_rw_type_all?
    return nil unless exists?
    event_selector_found = false
    if using_basic_event_selectors?
      begin
        @event_selectors.event_selectors.each do |es|
          event_selector_found = true if es.read_write_type == "All" &&
            es.include_management_events == true
        end
      rescue Aws::CloudTrail::Errors::TrailNotFoundException
        event_selector_found
      end
    else
      event_selector_found = @event_selectors.advanced_event_selectors.any? { |es|
        # check if readOnly is unset entirely (means both read and write are logged)
        es.field_selectors.none? { |fs| fs.field == "readOnly" } && \
          # check if a field selector is set to track management events
          es.field_selectors.any? { |fs| fs.field == "eventCategory" && fs.equals == ["Management"] }
      }
    end
    event_selector_found
  end

  def monitoring?(aws_resource_type, mode)
    # basic event selectors have a simpler structure than the advanced ones - check basic first
    if using_basic_event_selectors?
      basic_mode = mode == "r" ? "ReadOnly" : "WriteOnly"
      @event_selectors.event_selectors.any? do |es|
        es.read_write_type.match?(/All|#{basic_mode}/) &&
          es.data_resources.any? do |dr|
            dr.type.include?(aws_resource_type) &&
              # make sure the values do not indicate individual resources
              dr.values.all? do |val|
                # val can be of the form 'arn:aws:s3' but not 'arn:aws:s3:<region>:<account>:<field>/<a_specific_resource>'
                val.split(%r{[:/]}).count <= 3
              end
          end
      end
    else
      read_only = mode == "r"
      @event_selectors.advanced_event_selectors.any? do |es|
        (
          es.field_selectors.any? do |fs| # check if readOnly is explicitly set to true
            fs.field == "readOnly" && fs.equals == [read_only.to_s] # NOTE: that AdvancedFieldSelector has a field named "equals"
            # also note that designating an AFS as writeOnly means setting
            # the readOnly field to 'false'
          end ||
            es.field_selectors.none? do |fs| # or check if readOnly is unset entirely (means both read and write are logged)
              fs.field == "readOnly"
            end
        ) &&
          es.field_selectors.any? do |fs| # check if some other field selector is set to the right resource type
            fs.field == "resources.type" && fs.equals == [aws_resource_type]
          end &&
          es.field_selectors.none? do |fs| # check that no other event selector is tracking an individual arn
            # if no arn field is set, cloudtrail is tracking the whole type
            fs.field.downcase == "resources.arn"
          end
      end
    end
  end

  def monitoring_read?(aws_resource_type)
    monitoring?(aws_resource_type, "r")
  end

  def monitoring_write?(aws_resource_type)
    monitoring?(aws_resource_type, "w")
  end

  def using_advanced_event_selectors?
    @event_selectors.advanced_event_selectors.present?
  end

  def using_basic_event_selectors?
    @event_selectors.event_selectors.present?
  end

  def exists?
    !@trail.nil? && !@trail.empty?
  end

  def to_s
    "CloudTrail #{@trail_name}"
  end
end

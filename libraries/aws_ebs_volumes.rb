require "aws_backend"

class AwsEbsVolumes < AwsResourceBase
  name "aws_ebs_volumes"
  desc "Verifies settings for a collection of AWS EBS Volumes."
  example "
    describe aws_ebs_volumes do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:attachments, field: :attachments)
    .register_column(:availability_zones, field: :availability_zone)
    .register_column(:create_times, field: :create_time)
    .register_column(:encrypted, field: :encrypted)
    .register_column(:kms_key_ids, field: :kms_key_id)
    .register_column(:outpost_arns, field: :outpost_arn)
    .register_column(:sizes, field: :size)
    .register_column(:snapshot_ids, field: :snapshot_id)
    .register_column(:states, field: :state)
    .register_column(:volume_ids, field: :volume_id)
    .register_column(:iops, field: :iops)
    .register_column(:tags, field: :tags)
    .register_column(:volume_types, field: :volume_type)
    .register_column(:fast_restored, field: :fast_restored)
    .register_column(:multi_attach_enabled, field: :multi_attach_enabled)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    volume_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_volumes(pagination_options)
      end
      return volume_rows if !@api_response || @api_response.empty?

      @api_response.volumes.map do |volume|
        volume_rows += [{
          attachments: volume.attachments,
                        availability_zone: volume.availability_zone,
                        create_time: volume.create_time,
                        encrypted: volume.encrypted,
                        kms_key_id: volume.kms_key_id,
                        outpost_arn: volume.outpost_arn,
                        size: volume.size,
                        snapshot_id: volume.snapshot_id,
                        state: volume.state,
                        volume_id: volume.volume_id,
                        iops: volume.iops,
                        tags: volume.tags,
                        volume_type: volume.volume_type,
                        fast_restored: volume.fast_restored,
                        multi_attach_enabled: volume.multi_attach_enabled,
        }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = volume_rows
  end
end

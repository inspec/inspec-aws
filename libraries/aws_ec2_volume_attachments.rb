require 'aws_backend'

class AWSEC2VolumeAttachments < AwsResourceBase
  name 'aws_ec2_volume_attachments'
  desc 'Describes the specified EBS volumes attachments or all of your EBS volumes attachments.'

  example "
    describe aws_ec2_volume_attachments do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:attach_times, field: :attach_time)
             .register_column(:devices, field: :device)
             .register_column(:instance_ids, field: :instance_id)
             .register_column(:states, field: :state)
             .register_column(:volume_ids, field: :volume_id)
             .register_column(:delete_on_terminations, field: :delete_on_termination)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    pagination_options = {}
    rows = []
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_volumes(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.volumes.each do |resp|
        next if resp.attachments.nil?
        rows += [{ attach_time: resp.attachments.map(&:attach_time),
                   device: resp.attachments.map(&:device),
                   instance_id: resp.attachments.map(&:instance_id),
                   state: resp.attachments.map(&:state),
                   volume_id: resp.attachments.map(&:volume_id),
                   delete_on_termination: resp.attachments.map(&:delete_on_termination) }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end

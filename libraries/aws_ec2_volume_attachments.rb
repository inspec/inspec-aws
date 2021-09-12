# frozen_string_literal: true

require 'aws_backend'

class AWSEc2VolumeAttachments < AwsResourceBase
  name 'aws_ec2_volume_attachments'
  desc 'Lists all the EC2 volume attachments.'

  example "
    describe aws_ec2_volume_attachments(volume_id: 'vol-1234567890') do
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
    validate_parameters(require_any_of: %i(volume_id name))
    @volume_arguments = {}
    if opts[:volume_id] && !opts[:volume_id].empty?
      raise ArgumentError, "#{@__resource_name__}:  must be in the format 'vol- followed by 8 or 17 hexadecimal characters." if opts[:volume_id] !~ /^vol\-([0-9a-f]{8})|(^vol\-[0-9a-f]{17})$/
      @display_name = opts[:volume_id]
      @volume_arguments = { volume_ids: [opts[:volume_id]] }
    elsif opts[:name] && !opts[:name].empty?
      @display_name = opts[:name]
      filter = { name: 'tag:Name', values: [opts[:name]] }
      @volume_arguments = { filters: [filter] }
    else
      raise ArgumentError, "#{@__resource_name__}: `volume_id` or `name` must be provided"
    end
    @table = fetch_data
  end

  def fetch_data
    rows = []
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_volumes(@volume_arguments)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.volumes[0].attachments.each do |res|
        rows += [{ attach_time: res.attach_time,
                   device: res.device,
                   instance_id: res.instance_id,
                   state: res.state,
                   volume_id: res.volume_id,
                   delete_on_termination: res.delete_on_termination }]
      end
      break unless @api_response.next_token
      @volume_arguments[:next_token] = @api_response.next_token
    end
    @table = rows
  end
end

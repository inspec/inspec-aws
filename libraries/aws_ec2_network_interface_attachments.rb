require 'aws_backend'

class AWSEC2NetworkInterfaceAttachments < AwsResourceBase
  name 'aws_ec2_network_interface_attachments'
  desc 'List all the network interface attachments.'

  example "
    describe aws_ec2_network_interface_attachments do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:attach_times, field: :attach_time)
             .register_column(:attachment_ids, field: :attachment_id)
             .register_column(:delete_on_terminations, field: :delete_on_termination)
             .register_column(:device_indexes, field: :device_index)
             .register_column(:network_card_indexes, field: :network_card_index)
             .register_column(:instance_ids, field: :instance_id)
             .register_column(:instance_owner_ids, field: :instance_owner_id)
             .register_column(:statuses, field: :status)
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
        @api_response = @aws.compute_client.describe_network_interfaces(pagination_options)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.network_interfaces.each do |resp|
        next if resp.attachment.nil?
        rows += [{ attach_time:  resp.attachment[:attach_time],
                   attachment_id:  resp.attachment[:attachment_id],
                   delete_on_termination:  resp.attachment.delete_on_termination,
                   device_index:  resp.attachment.device_index,
                   network_card_index:  resp.attachment.network_card_index,
                   instance_id:  resp.attachment.instance_id,
                   instance_owner_id:  resp.attachment.instance_owner_id,
                   status:  resp.attachment.status }]
      end
      break unless @api_response.next_token
      pagination_options[:next_token] = @api_response.next_token
    end
    rows
  end
end

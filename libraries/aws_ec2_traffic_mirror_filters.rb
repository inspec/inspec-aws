require 'aws_backend'

class AWSEc2TrafficMirrorFilters < AwsResourceBase
  name 'aws_ec2_traffic_mirror_filters'
  desc 'Describes one or more Traffic Mirror filters.'

  example "
    describe aws_ec2_traffic_mirror_filters do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:traffic_mirror_filter_ids,      field: :traffic_mirror_filter_id)
             .register_column(:descriptions,                   field: :description)
             .register_column(:tags,                           field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    traffic_mirror_filters_rows = []
    pagination_options = {}
    pagination_options[:max_results] = 100
    loop do
      catch_aws_errors do
        @api_response = @aws.compute_client.describe_traffic_mirror_filters(pagination_options)
      end
      return traffic_mirror_filters_rows if !@api_response || @api_response.empty?
      @api_response.traffic_mirror_filters.each do |traffic_mirror_filter|
        traffic_mirror_filters_tags = map_tags(traffic_mirror_filter.tags)
        traffic_mirror_filters_rows += [{ traffic_mirror_filter_id: traffic_mirror_filter.traffic_mirror_filter_id,
                                          description: traffic_mirror_filter.description,
                                          tags: traffic_mirror_filters_tags }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = traffic_mirror_filters_rows
  end
end

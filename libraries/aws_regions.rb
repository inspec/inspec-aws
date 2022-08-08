# frozen_string_literal: true

require 'aws_backend'

class AwsRegions < AwsResourceBase
  name 'aws_regions'
  desc 'Verifies settings for AWS Regions in bulk.'

  example "
    describe aws_regions do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:region_names, field: :region_name)
             .register_column(:endpoints,    field: :endpoint)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    region_rows = []
    @query_params = {}
    @query_params[:region_names] = if opts[:region_names].is_a?(Array) || opts[:region_names].nil?
                                     if opts[:region_names].nil?
                                       @query_params[:all_regions] = true
                                     end
                                     opts[:region_names]
                                   else [opts[:region_names]]
                                   end
    catch_aws_errors do
      @regions = @aws.compute_client.describe_regions((@query_params)).to_h[:regions]
    end
    return region_rows if !@regions || @regions.empty?
    @regions.each do |region|
      region_rows += [{ region_name: region[:region_name],
                        endpoint: region[:endpoint] }]
    end
    @table = region_rows
  end
end

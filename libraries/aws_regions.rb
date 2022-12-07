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
    update_regions(opts)
    super(opts)
    validate_parameters(require_any_of: %i(region_names all_regions))
    @table = fetch_data
  end

  def fetch_data
    region_rows = []
    query_param
    catch_aws_errors do
      # require 'byebug';byebug
      @regions = @aws.compute_client.describe_regions((@query_params)).to_h[:regions]
    end
    return region_rows if !@regions || @regions.empty?
    @regions.each do |region|
      region_rows += [{ region_name: region[:region_name],
                        endpoint: region[:endpoint] }]
    end
    @table = region_rows
  end

  private

  def query_param
    @query_params = {}
    if !opts[:all_regions]
      @query_params[:all_regions] = opts[:all_regions]
      @query_params[:region_names] = if opts[:region_names].is_a?(Array)
                                       opts[:region_names]
                                     else
                                       [opts[:region_names]]
                                     end
    end
  end

  def update_regions(opts)
    opts = { region_names: opts } if opts.is_a?(String) || opts.is_a?(Array)
    if !opts[:region_names].is_a?(Array) && !opts[:region_names].is_a?(String)
      opts[:all_regions] = true
      opts.delete(:region_names)
    else
      opts[:all_regions] = false
    end
    opts
  end
end
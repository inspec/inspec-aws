require 'aws_backend'

class AWSServiceCatalogPortfolioProductAssociations < AwsResourceBase
  name 'aws_servicecatalog_portfolio_product_associations'
  desc 'Lists all portfolios that the specified product is associated with.'

  example "
    describe aws_servicecatalog_portfolio_product_associations(product_id: 'test1') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids,                                field: :id)
             .register_column(:arns,                               field: :arn)
             .register_column(:display_names,                      field: :display_name)
             .register_column(:descriptions,                       field: :description)
             .register_column(:created_times,                      field: :created_time)
             .register_column(:provider_names,                     field: :provider_name)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(product_id))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: product_id must be provided" unless opts[:product_id] && !opts[:product_id].empty?
    @query_params[:product_id] = opts[:product_id]
    @table = fetch_data
  end

  def fetch_data
    rows = []
    @query_params[:page_size] = 20
    loop do
      catch_aws_errors do
        @api_response = @aws.servicecatalog_client.list_portfolios_for_product(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.portfolio_details.each do |resp|
        rows += [{ id: resp.id,
                   arn: resp.arn,
                   display_name: resp.display_name,
                   description: resp.description,
                   created_time: resp.created_time,
                   provider_name: resp.provider_name }]
      end
      break unless @api_response.next_page_token
      @query_params[:page_token] = @api_response.next_page_token
    end
    rows
  end
end

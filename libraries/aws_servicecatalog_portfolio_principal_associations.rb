require "aws_backend"

class AWSServiceCatalogPortfolioPrincipalAssociations < AwsResourceBase
  name "aws_servicecatalog_portfolio_principal_associations"
  desc "Lists all principal ARNs associated with the specified portfolio."

  example "
    describe aws_servicecatalog_portfolio_principal_associations(portfolio_id: 'test1') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:principal_arns,                                field: :principal_arn)
    .register_column(:principal_types,                               field: :principal_type)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(portfolio_id))
    @query_params = {}
    @query_params[:portfolio_id] = opts[:portfolio_id]
    raise ArgumentError, "#{@__resource_name__}: portfolio_id must be provided" unless opts[:portfolio_id] && !opts[:portfolio_id].empty?
    @query_params[:portfolio_id] = opts[:portfolio_id]
    @table = fetch_data
  end

  def fetch_data
    rows = []
    @query_params[:page_size] = 20
    loop do
      catch_aws_errors do
        @api_response = @aws.servicecatalog_client.list_principals_for_portfolio(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.principals.each do |resp|
        rows += [{ principal_arn: resp.principal_arn,
                   principal_type: resp.principal_type }]
      end
      break unless @api_response.next_page_token
      @query_params[:next_page_token] = @api_response.next_page_token
    end
    rows
  end
end

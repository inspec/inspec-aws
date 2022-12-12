require "aws_backend"

class AWSServiceCatalogLaunchRoleConstraints < AwsResourceBase
  name "aws_servicecatalog_launch_role_constraints"
  desc "Lists the constraints for the specified portfolio and product."

  example "
    describe aws_servicecatalog_launch_role_constraints(portfolio_id: 'portfolio_id') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:constraint_ids,                                 field: :constraint_id)
    .register_column(:types,                                          field: :type)
    .register_column(:descriptions,                                   field: :description)
    .register_column(:owners,                                         field: :owner)
    .register_column(:product_ids,                                    field: :product_id)
    .register_column(:portfolio_ids,                                  field: :portfolio_id)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(portfolio_id))
    @query_params = {}
    @query_params[:portfolio_id] = opts[:portfolio_id]
    if opts.key?(:portfolio_id)
      raise ArgumentError, "#{@__resource_name__}: portfolio_id must be provided" unless opts[:portfolio_id] && !opts[:portfolio_id].empty?
      @query_params[:portfolio_id] = opts[:portfolio_id]
    end
    @table = fetch_data
  end

  def fetch_data
    rows = []
    @query_params[:page_size] = 20
    loop do
      catch_aws_errors do
        @api_response = @aws.servicecatalog_client.list_constraints_for_portfolio(@query_params)
      end
      return rows if !@api_response || @api_response.empty?

      @api_response.constraint_details.each do |resp|
        rows += [{ constraint_id: resp.constraint_id,
                   type: resp.type,
                   description: resp.description,
                   owner: resp.owner,
                   product_id: resp.product_id,
                   portfolio_id: resp.portfolio_id }]
      end
      break unless @api_response.next_page_token
      @query_params[:next_page_token] = @api_response.next_page_token
    end
    @table = rows
  end
end

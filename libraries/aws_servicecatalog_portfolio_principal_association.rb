require "aws_backend"

class AWSServiceCatalogPortfolioPrincipalAssociation < AwsResourceBase
  name "aws_servicecatalog_portfolio_principal_association"
  desc "Lists all principal ARNs associated with the specified portfolio."

  example "
    describe aws_servicecatalog_portfolio_principal_association(portfolio_id: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { portfolio_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:portfolio_id])
    unless opts[:portfolio_id] && !opts[:portfolio_id].empty?
      raise ArgumentError,
            "#{@__resource_name__}: portfolio_id must be provided"
    end
    @display_name = opts[:portfolio_id]
    catch_aws_errors do
      resp =
        @aws.servicecatalog_client.list_principals_for_portfolio(
          { portfolio_id: opts[:portfolio_id] }
        )
      @res = resp.principals[0].to_h
      @principal_arn = @res[:principal_arn]
      create_resource_methods(@res)
    end
  end

  def resource_id
    @principal_arn
  end

  def portfolio_id
    return nil unless exists?
    @res[:portfolio_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Portfolio ID: #{@display_name}"
  end
end

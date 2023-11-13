require "aws_backend"

class AWSServiceCatalogPortfolioProductAssociation < AwsResourceBase
  name "aws_servicecatalog_portfolio_product_association"
  desc "Describe a portfolio that the specified product is associated with."

  example "
    describe aws_servicecatalog_portfolio_product_association(product_id: 'test1') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { product_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:product_id])
    raise ArgumentError, "#{@__resource_name__}: product_id must be provided" unless opts[:product_id] && !opts[:product_id].empty?
    @display_name = opts[:product_id]
    catch_aws_errors do
      resp = @aws.servicecatalog_client.list_portfolios_for_product({ product_id: opts[:product_id] })
      @res = resp.portfolio_details[0].to_h
      @arn = @res[:arn]
      create_resource_methods(@res)
    end
  end

  def resource_id
    @arn
  end

  def product_id
    return unless exists?
    @res[:product_id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Product ID: #{@display_name}"
  end
end

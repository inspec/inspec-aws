require "aws_backend"

class AWSRoute53ResolverResolverRuleAssociation < AwsResourceBase
  name "aws_route53resolver_resolver_rule_association"
  desc "Gets information about an association between a specified Resolver rule and a VPC."

  example "
    describe aws_route53resolver_resolver_rule_association(resolver_rule_association_id: 'ResourceId') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { resolver_rule_association_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i[resolver_rule_association_id])
    unless opts[:resolver_rule_association_id] &&
             !opts[:resolver_rule_association_id].empty?
      raise ArgumentError,
            "#{@__resource_name__}: resource_share_arn must be provided"
    end
    @display_name = opts[:resolver_rule_association_id]
    catch_aws_errors do
      resp =
        @aws.route53resolver_client.get_resolver_rule_association(
          { resolver_rule_association_id: opts[:resolver_rule_association_id] }
        )
      @res = resp.resolver_rule_association.to_h
      create_resource_methods(@res)
    end
  end

  def resolver_rule_association_id
    return unless exists?
    @res[:id]
  end

  def resource_id
    @res ? @res[:id] : @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Resolver Endpoint Association ID: #{@display_name}"
  end
end

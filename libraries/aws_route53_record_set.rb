require "aws_backend"

class AWSRoute53RecordSet < AwsResourceBase
  name "aws_route53_record_set"
  desc "Describe a resource record sets in a specified hosted zone."

  example "
    describe aws_route53_record_set(hosted_zone_id: 'ResourceId', start_record_name: 'DNSName') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i[hosted_zone_id start_record_name])
    unless opts[:hosted_zone_id] && !opts[:hosted_zone_id].empty?
      raise ArgumentError,
            "#{@__resource_name__}: hosted_zone_id must be provided"
    end
    unless opts[:start_record_name] && !opts[:start_record_name].empty?
      raise ArgumentError,
            "#{@__resource_name__}: start_record_name must be provided"
    end
    @hosted_zone_id = opts[:hosted_zone_id]
    @start_record_name = opts[:start_record_name]
    catch_aws_errors do
      resp =
        @aws.route53_client.list_resource_record_sets(
          {
            hosted_zone_id: opts[:hosted_zone_id],
            start_record_name: opts[:name]
          }
        )
      @res = resp.resource_record_sets[0].to_h
      create_resource_methods(@res)
    end
  end

  def hosted_zone_id
    return nil unless exists?
    @res[:alias_target][:hosted_zone_id]
  end

  def resource_id
    "#{@res ? @hosted_zone_id : ""}_#{@res ? @start_record_name : ""}"
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Record Name: #{@start_record_name}"
  end
end

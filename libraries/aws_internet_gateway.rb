require "aws_backend"

class AwsInternetGateway < AwsResourceBase
  name "aws_internet_gateway"
  desc "Verifies settings for an AWS Internet Gateway."

  example "
    describe aws_internet_gateway(id: 'igw-abc12450edc87a8bd') do
      it { should be_attached }
    end

    describe aws_internet_gateway(name: 'my-gateway') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(require_any_of: %i[id name])

    # Either id or name should be provided.
    if opts.key?(:id) && !opts.key?(:name)
      id = opts[:id]
      format_error =
        "#{@__resource_name__}: `id` must be a string in the format of " \
          "'igw-' followed by 8 or 17 hexadecimal characters."
      pattern = /^igw-[0-9a-f]{8,17}$/
      unless id.match?(pattern) || id.length.between?(12, 21)
        raise ArgumentError, format_error
      end
      query_params = { internet_gateway_ids: [id] }
    elsif opts.key?(:name) && !opts.key?(:id)
      name = opts[:name]
      tag_error =
        "#{@__resource_name__}: `name` should be maximum 255 characters long and contain " \
          "letters, numbers, spaces and the following characters only: + - = . _ : / @"
      unless name.match?(%r{^[\w+\- =._:/@]{1,256}$}) &&
               name.length.between?(1, 255)
        raise ArgumentError, tag_error
      end
      query_params = { filters: [name: "tag:Name", values: [name]] }
    else
      raise ArgumentError,
            "#{@__resource_name__}: either `id` or `name` must be provided."
    end
    @display_name = opts.values.join(" ")

    catch_aws_errors do
      resp = @aws.compute_client.describe_internet_gateways(query_params)
      gateways = resp.internet_gateways
      # API will return an empty list if there is no resource with the provided name tag.
      if gateways.empty?
        Inspec::Log.warn "#{@__resource_name__}: #{@display_name} not found. "
        # This parameter exists in the base class and the value is returned by `failed_resource?` method.
        @failed_resource = true
        return
      end
      # Fail resource, redirect users to plural resource if there are multiple resources with the same name tag.
      if gateways.length > 1
        fail_resource(
          "#{@__resource_name__}: Multiple internet gateways were returned for the provided parameter:" \
            " `#{@display_name}`. If you wish to test multiple internet gateways, " \
            "please use the aws_internet_gateways resource."
        )
        @failed_resource = true
        return
      end
      @igw = gateways.first.to_h
      create_resource_methods(@igw)
    end
  end

  def exists?
    failed_resource? ? false : true
  end

  def id
    return unless exists?
    internet_gateway_id
  end

  def name
    return unless exists?
    tags["Name"] if tags.key?("Name")
  end

  def tags
    return unless exists?
    tags
  end

  def vpc_id
    return unless exists?
    return if attachments.empty?
    # Only one internet gateway can be attached to a VPC at a time. (Internet gateways per Region)
    # https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html
    # You cannot attach an internet gateway to more than one VPC at a time. (Resource.AlreadyAssociated)
    # https://docs.aws.amazon.com/AWSEC2/latest/APIReference/errors-overview.html
    # Even though attachments is a list type object, it won't contain more than one VPC (see above).
    attachments.first.vpc_id
  end

  def attached?
    return unless exists?
    # empty attachments means it is not attached to any VPC.
    return false if attachments.empty?
    # available means it is attached to a VPC.
    # https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InternetGatewayAttachment.html
    attachments.first.state == "available"
  end

  def detached?
    return unless exists?
    !attached?
  end

  def resource_id
    @igw ? @igw[:internet_gateway_id] : @display_name
  end

  def to_s
    "Internet Gateway #{@display_name}"
  end
end

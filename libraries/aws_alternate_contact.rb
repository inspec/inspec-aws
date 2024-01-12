require "aws_backend"

class AwsAlternateAccount < AwsResourceBase
  name "aws_alternate_contact"
  desc "Verifies the billing contact information for an AWS Account."
  example <<~EXAMPLE1
    describe aws_alternate_account(type: 'billing') do
        it { should be_configured }
        its('name') { should cmp 'John Smith' }
        its('email_address') { should cmp 'jsmith@acme.com' }
      end
  EXAMPLE1

  example <<~EXAMPLE2
    describe aws_alternate_account('security') do
      it { should be_configured }
      its('name') { should cmp 'Jane Smith' }
      its('email_address') { should cmp 'janesmith@acme.com' }
    end
  EXAMPLE2

  attr_reader :raw_data,
              :api,
              :api_response,
              :email_address,
              :name,
              :phone_number,
              :title,
              :aws_account_id

  def initialize(opts = {})
    @raw_data = {}
    supported_opt_keys = %i(type)
    supported_opts_values = %w{billing operations security}
    opts = { type: opts } if opts.is_a?(String)

    unless opts.respond_to?(:keys)
      raise ArgumentError,
            "Invalid aws_alternate_contact param '#{opts}'. Please pass a hash with these supported key(s): #{supported_opt_keys}"
    end
    unless (opts.keys - supported_opt_keys).empty?
      raise ArgumentError,
            "Unsupported aws_alternate_contact options '#{opts.keys - supported_opt_keys}'. Supported key(s): #{supported_opt_keys}"
    end
    unless opts.keys && (opts.keys & supported_opt_keys).length == 1
      raise ArgumentError,
            "Specifying more than one of :type for aws_alternate_account is not supported"
    end
    unless supported_opts_values.any? { |val| opts.values.include?(val) }
      raise ArgumentError,
            "You may only pass a value of type: #{supported_opts_values} as the ':type' for aws_alternate_account"
    end
    super(opts)
    validate_parameters(required: [:type])
    catch_aws_errors do
      begin
        @aws_account_id = fetch_aws_account
        @api_response = fetch_aws_alternate_contact(opts[:type])
      rescue Aws::Account::Errors::ResourceNotFoundException
        skip_resource(
          "The #{opts[:type].uppercase} contact has not been configured for this AWS Account.",
        )
        return
      rescue Aws::Errors::NoSuchEndpointError, Seahorse::Client::NetworkingError
        skip_resource(
          "The account contact endpoint is not available in this segment, please review this via the AWS Management Console.",
        )
      end
      return [] if !@api_response || @api_response.empty?
    end

    unless @api_response.nil?
      @api_response
        .members
        .map(&:to_s)
        .each do |key|
          instance_variable_set("@#{key}", @api_response.send(key))
        end
      @raw_data = @api_response.to_h.transform_keys(&:to_s)
    else
      @name, @email_address, @phone_number, @title = ""
    end
  end

  def configured?
    !@api_response.nil? || !@raw_data
  end

  alias exist? configured?

  def resource_id
    if @aws_account_id
      "AWS #{opts[:type].capitalize} Contact for account: #{@aws_account_id}"
    else
      "AWS #{opts[:type].capitalize} Contact Information"
    end
  end

  def to_s
    if @aws_account_id
      "AWS #{opts[:type].capitalize} Contact for account: #{@aws_account_id}"
    else
      "AWS Account #{opts[:type].capitalize} Contact"
    end
  end

  private

  def fetch_aws_account
    arn = @aws.sts_client.get_caller_identity({}).arn
    arn.split(":")[4]
  end

  def fetch_aws_alternate_contact(type)
    @aws
      .account_client
      .get_alternate_contact({ alternate_contact_type: type.upcase.to_s })
      .alternate_contact
  end
end

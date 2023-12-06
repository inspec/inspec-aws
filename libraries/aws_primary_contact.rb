require "aws_backend"

class AwsPrimaryAccount < AwsResourceBase
  name "aws_primary_contact"
  desc "Verifies the primary contact information for an AWS Account."
  example <<~EXAMPLE
    describe aws_primary_contact do
      it { should be_configured }
      its('full_name') { should cmp 'John Smith' }
      its('address_line_1') { should cmp '42 Wallaby Way' }
    end
  EXAMPLE

  attr_reader :raw_data,
              :api_response,
              :address_line_1,
              :address_line_2,
              :address_line_3,
              :city,
              :country_code,
              :company_name,
              :district_or_county,
              :full_name,
              :phone_number,
              :postal_code,
              :state_or_region,
              :website_url,
              :aws_account_id

  def initialize(opts = {})
    @raw_data = {}
    @address_line_1,
    @address_line_2,
    @address_line_3,
    @city,
    @country_code,
    @company_name,
    @district_or_county,
    @full_name,
    @phone_number,
    @postal_code,
    @state_or_region,
    @website_url =
      ""
    super(opts)
    validate_parameters
    begin
      catch_aws_errors { @aws_account_id = fetch_aws_account }
      @api_response =
        @aws.account_client.get_contact_information.contact_information
    rescue Aws::Account::Errors::ResourceNotFoundException
      skip_resource(
        "The Primary contact has not been configured for this AWS Account.",
      )
      return [] if !@api_response || @api_response.empty?
    end

    if @api_response
      @api_response
        .members
        .map(&:to_s)
        .each do |key|
          instance_variable_set("@#{key}", @api_response.send(key))
        end
    end
    @raw_data = @api_response.to_h.transform_keys(&:to_s)
  end

  def configured?
    !@api_response.nil? || !@raw_data
  end

  alias exist? configured?

  def resource_id
    if @aws_account_id
      "AWS Primary Contact for account: #{@aws_account_id}"
    else
      "AWS Account Primary Contact Information"
    end
  end

  alias to_s

  private

  def fetch_aws_account
    arn = @aws.sts_client.get_caller_identity({}).arn
    arn.split(":")[4]
  end
end

require "aws_backend"

class AwsPrimaryAccount < AwsResourceBase
  name "aws_primary_contact"
  desc "Verifies the primary contact information for an AWS Account."
  example <<~EXAMPLE
    describe aws_primary_account do
      it { should be_configured }
      its('full_name') { should cmp 'John Smith' }
      its('address_line_1') { should cmp '42 Wallaby Way' }
    end
  EXAMPLE

  attr_reader :table, :raw_data

  FilterTable
    .create
    .register_column(:address_line_1, field: :address_line_1, style: :simple)
    .register_column(:adress_line_2, field: :adress_line_2, style: :simple)
    .register_column(:address_line_3, field: :address_line_3, style: :simple)
    .register_column(:city, field: :city, style: :simple)
    .register_column(:company_name, field: :company_name, style: :simple)
    .register_column(:country_code, field: :country_code, style: :simple)
    .register_column(
      :district_or_county,
      field: :district_or_county,
      style: :simple
    )
    .register_column(:full_name, field: :full_name, style: :simple)
    .register_column(:phone_number, field: :phone_number, style: :simple)
    .register_column(:postal_code, field: :postal_code, style: :simple)
    .register_column(:state_or_region, field: :state_or_region, style: :simple)
    .register_column(:website_url, field: :website_url, style: :simple)
    .register_custom_matcher(:configured?) { |x| x.entries.any? }
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    begin
      @aws.account_client.get_contact_information
    rescue Aws::Account::Errors::ResourceNotFoundException
      skip_resource(
        "The Primary contact has not been configured for this AWS Account."
      )
      @failed_resource = true
      return
    end
    @table = fetch_data
  end

  def resource_id
    "AWS Account for #{@table[0][:full_name]}" ||
      "AWS Account Contact Information"
  end

  def to_s
    "AWS Account Primary Contact"
  end

  def fetch_data
    @raw_data = []
    loop do
      catch_aws_errors do
        @api_response =
          @aws.account_client.get_contact_information.contact_information
      end
      return [] if !@api_response || @api_response.empty?

      @raw_data << {
        address_line_1: @api_response.address_line_1,
        address_line_2: @api_response.address_line_2,
        address_line_3: @api_response.address_line_3,
        city: @api_response.city,
        company_name: @api_response.company_name,
        country_code: @api_response.country_code,
        district_or_county: @api_response.district_or_county,
        full_name: @api_response.full_name,
        phone_number: @api_response.phone_number,
        postal_code: @api_response.postal_code,
        state_or_region: @api_response.state_or_region,
        website_url: @api_response.website_url
      }
      break
    end
    @raw_data
  end

  class AwsBillingAccount < AwsResourceBase
    name "aws_billing_contact"
    desc "Verifies the billing contact information for an AWS Account."
    example <<~EXAMPLE
      describe aws_billing_account do
        it { should be_configured }
        its('name') { should cmp 'John Smith' }
        its('email_address') { should cmp 'jsmith@acme.com' }
      end
    EXAMPLE

    attr_reader :table, :raw_data

    FilterTable
      .create
      .register_column(:email_address, field: :email_address, style: :simple)
      .register_column(:name, field: :name, style: :simple)
      .register_column(:phone_number, field: :phone_number, style: :simple)
      .register_column(:title, field: :title, style: :simple)
      .register_custom_matcher(:configured?) { |x| x.entries.any? }
      .install_filter_methods_on_resource(self, :table)

    def initialize(opts = {})
      super(opts)
      validate_parameters
      begin
        @aws.account_client.get_alternate_contact(
          { alternate_contact_type: "BILLING" }
        )
      rescue Aws::Account::Errors::ResourceNotFoundException
        skip_resource(
          "The BILLING contact has not been configured for this AWS Account."
        )
        @failed_resource = true
        return
      end
      @table = fetch_data
    end

    def resource_id
      "AWS Billing for #{@table[0][:name]}" || "AWS Account Billing Information"
    end

    def to_s
      "AWS Account Billing Contact"
    end

    def fetch_data
      @raw_data = []
      loop do
        catch_aws_errors do
          @api_response =
            @aws
              .account_client
              .get_alternate_contact({ alternate_contact_type: "BILLING" })
              .alternate_contact
        end
        return [] if !@api_response || @api_response.empty?

        @raw_data << {
          email_address: @api_response.email_address,
          name: @api_response.name,
          phone_number: @api_response.phone_number,
          title: @api_response.title
        }
        break
      end
      @raw_data
    end
  end

  class AwsAccountOperationsContact < AwsResourceBase
    name "aws_operations_contact"
    desc "Verifies the operations contact information for an AWS Account."
    example <<~EXAMPLE
      describe aws_operations_account do
        it { should be_configured }
        its('name') { should cmp 'John Smith' }
        its('email_address') { should cmp 'jsmith@acme.com' }
      end
    EXAMPLE

    attr_reader :table, :raw_data

    FilterTable
      .create
      .register_column(:email_address, field: :email_address, style: :simple)
      .register_column(:name, field: :name, style: :simple)
      .register_column(:phone_number, field: :phone_number, style: :simple)
      .register_column(:title, field: :title, style: :simple)
      .register_custom_matcher(:configured?) { |x| x.entries.any? }
      .install_filter_methods_on_resource(self, :table)

    def initialize(opts = {})
      super(opts)
      validate_parameters
      begin
        @aws.account_client.get_alternate_contact(
          { alternate_contact_type: "OPERATIONS" }
        )
      rescue Aws::Account::Errors::ResourceNotFoundException
        skip_resource(
          "The Operations contact has not been configured for this AWS Account."
        )
        @failed_resource = true
        return
      end
      @table = fetch_data
    end

    def resource_id
      "AWS Operations Contact for #{@table[0][:name]}" ||
        "AWS Account Operations Contact Information"
    end

    def to_s
      "AWS Account Operations Contact Information"
    end

    def fetch_data
      @raw_data = []
      loop do
        catch_aws_errors do
          @api_response =
            @aws
              .account_client
              .get_alternate_contact({ alternate_contact_type: "OPERATIONS" })
              .alternate_contact
        end
        return [] if !@api_response || @api_response.empty?

        @raw_data << {
          email_address: @api_response.email_address,
          name: @api_response.name,
          phone_number: @api_response.phone_number,
          title: @api_response.title
        }
        break
      end
      @raw_data
    end
  end

  class AwsAccountSecurityContact < AwsResourceBase
    name "aws_security_contact"
    desc "Verifies the security contact information for an AWS Account."
    example <<~EXAMPLE
      describe aws_security_account do
        it { should be_configured }
        its('name') { should cmp 'John Smith' }
        its('email_address') { should cmp 'jsmith@acme.com' }
      end
    EXAMPLE

    attr_reader :table, :raw_data

    FilterTable
      .create
      .register_column(:email_address, field: :email_address, style: :simple)
      .register_column(:name, field: :name, style: :simple)
      .register_column(:phone_number, field: :phone_number, style: :simple)
      .register_column(:title, field: :title, style: :simple)
      .register_custom_matcher(:configured?) { |x| x.entries.any? }
      .install_filter_methods_on_resource(self, :table)

    def initialize(opts = {})
      super(opts)
      validate_parameters
      begin
        @aws.account_client.get_alternate_contact(
          { alternate_contact_type: "SECURITY" }
        )
      rescue Aws::Account::Errors::ResourceNotFoundException
        skip_resource(
          "The Security contact has not been configured for this AWS Account."
        )
        @failed_resource = true
        return
      end
      @table = fetch_data
    end

    def resource_id
      "AWS Security Contact for #{@table[0][:name]}" ||
        "AWS Account Security Contact Information"
    end

    def to_s
      "AWS Account Security Contact"
    end

    def fetch_data
      @raw_data = []
      loop do
        catch_aws_errors do
          @api_response =
            @aws
              .account_client
              .get_alternate_contact({ alternate_contact_type: "SECURITY" })
              .alternate_contact
        end
        return [] if !@api_response || @api_response.empty?

        @raw_data << {
          email_address: @api_response.email_address,
          name: @api_response.name,
          phone_number: @api_response.phone_number,
          title: @api_response.title
        }
        break
      end
      @raw_data
    end
  end
end

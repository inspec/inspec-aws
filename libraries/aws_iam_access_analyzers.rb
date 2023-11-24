require 'aws_backend'
require 'pry'

class AwsIamAccessAnalyzer < AwsResourceBase
  name 'aws_iam_access_analyzers'
  desc 'Verifies settings for a collection AWS IAM Access Analyzers.'
  example <<~EXAMPLE1
    # retrieve both 'account' and 'organization' analyzers
    describe aws_iam_access_analyzers do
      it { should exist }
    end
  EXAMPLE1

  example <<~EXAMPLE2
    # retrieve only 'account' analyzers
    describe aws_iam_access_analyzers('account') do
      it { should exist }
    end
  EXAMPLE2

  example <<~EXAMPLE3
    # retrieve only 'account' analyzers
    describe aws_iam_access_analyzers(type: 'account') do
      it { should exist }
    end
  EXAMPLE3

  attr_reader :table, :raw_data, :api_response, :aws_account_id, :parameters

  FilterTable
    .create
    .register_column(:analyzer_names, field: :name)
    .register_column(:analyzer_type, field: :type)
    .register_column(:arns, field: :arn)
    .register_column(:created_date, field: :created_at)
    .register_column(:last_resource_analyzed, field: :last_resource_analyzed)
    .register_column(:last_analyzed_date, field: :last_resource_analyzed_at)
    .register_column(:tags, field: :tags)
    .register_column(:status, field: :status)
    .register_column(:status_reason, filed: :status_reason)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    @raw_data = []
    parameters = {}
    @api_response = nil
    @supported_opts_values = %w{account organization all}
    opts = { type: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(allow: %i(type aws_region))
    parameters[:type] = opts[:type].upcase if opts[:type]
    unless @supported_opts_values.map(&:upcase).include?(parameters[:type]) || parameters[:type].nil?
      raise ArgumentError, "Unsupported Account Type: '#{parameters[:type].downcase}'.  Supported account types: #{@supported_opts_values}"
    end
    @table = fetch_data(parameters)
  end

  def fetch_data(parameters)
    analyzer_rows = []

    catch_aws_errors do
      catch_aws_errors { @aws_account_id = fetch_aws_account }
      if parameters.empty? || parameters[:type] == 'ALL'
        @api_response = @aws.access_analyzer_client.list_analyzers
      elsif parameters[:type] == 'ACCOUNT' ||
            parameters[:type] == 'ORGANIZATION'
        @api_response = @aws.access_analyzer_client.list_analyzers(parameters)
      end

      @api_response.analyzers.each do |aa|
        analyzer_rows += [
          {
            arn: aa.arn,
            name: aa.name,
            type: aa.type,
            created_at: aa.created_at,
            last_resource_analyzed: aa.last_resource_analyzed,
            last_resource_analyzed_at: aa.last_resource_analyzed_at,
            # TODO: Flatten the hash of tags?
            tags: aa.tags,
            status: aa.status,
            status_reason: aa.status_reason,
          },
        ]
      end
      @raw_data =
        @api_response[:analyzers].empty? ? [] : @api_response.to_h[:analyzers]
    end
    @table = analyzer_rows
  end

  def resource_id
    response = 'AWS IAM '
    opts[:type] ? response += "#{opts[:type].capitalize} " : ''
    if @aws_account_id
      response +=
        "Account Analyzer for #{@aws_account_id} in #{get_current_region}"
    else
      response += "Account Analyzer Information in #{get_current_region}"
    end
    response
  end

  def to_s
    response = 'AWS IAM '
    opts[:type] ? response += "#{opts[:type].capitalize} " : ''
    if @aws_account_id
      response +=
        "Account Analyzer for #{@aws_account_id} in #{get_current_region}"
    else
      response += "Account Analyzer Information in #{get_current_region}"
    end
    response
  end

  private

  def fetch_aws_account
    arn = @aws.sts_client.get_caller_identity({}).arn
    arn.split(':')[4]
  end

  def get_current_region
    @aws.access_analyzer_client.config.region
  end
end

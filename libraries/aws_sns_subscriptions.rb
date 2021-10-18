# frozen_string_literal: true

require 'aws_backend'

class AWSSNSSubscriptions < AwsResourceBase
  name 'aws_sns_subscriptions'
  desc 'Verifies setting for a SNS Subscriptions.'

  example "
    describe aws_sns_subscriptions do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:subscription_arns, field: :subscription_arn)
             .register_column(:owners, field: :owner)
             .register_column(:protocols, field: :protocol)
             .register_column(:endpoints, field: :endpoint)
             .register_column(:topic_arns, field: :topic_arn)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @resp = @aws.sns_client.list_subscriptions
    end
    return [] if !@resp || @resp.empty?
    @table = @resp.subscriptions.map(&:to_h)
  end
end

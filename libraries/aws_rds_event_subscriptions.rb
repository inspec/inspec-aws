require 'aws_backend'

class AWSRDSEventSubscriptions < AwsResourceBase
  name 'aws_rds_event_subscriptions'
  desc 'Returns information about DB Event Subscription.'

  example "
    describe aws_rds_event_subscriptions do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:customer_aws_ids, field: :customer_aws_id)
             .register_column(:cust_subscription_ids, field: :cust_subscription_id)
             .register_column(:sns_topic_arns, field: :sns_topic_arn)
             .register_column(:statuses, field: :status)
             .register_column(:subscription_creation_times, field: :subscription_creation_time)
             .register_column(:source_types, field: :source_type)
             .register_column(:source_ids_list, field: :source_ids_list, style: :simple)
             .register_column(:event_categories_list, field: :event_categories_list, style: :simple)
             .register_column(:enabled, field: :enabled)
             .register_column(:event_subscription_arns, field: :event_subscription_arn)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.rds_client.describe_event_subscriptions.map do |table|
        table.event_subscriptions_list.map { |table_name| {
          customer_aws_id: table_name.customer_aws_id,
          cust_subscription_id: table_name.cust_subscription_id,
          sns_topic_arn: table_name.sns_topic_arn,
          status: table_name.status,
          source_type: table_name.source_type,
          subscription_creation_time: table_name.subscription_creation_time,
          source_ids_list: table_name.source_ids_list,
          event_categories_list: table_name.event_categories_list,
          enabled: table_name.enabled,
          event_subscription_arn: table_name.event_subscription_arn,
        }
        }
      end.flatten
    end
  end
end

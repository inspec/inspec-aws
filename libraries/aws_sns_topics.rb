require 'aws_backend'

class AwsSnsTopics < AwsResourceBase
  name 'aws_sns_topics'
  desc 'Verifies settings for SNS Topics in bulk.'
  example "
    describe aws_sns_topics do
      its('topic_arns') { should include 'arn:aws:sns:us-west-2:012345678901:aws-sns-topic-auzoitotenajpdiftuiorkmrf' }
    end
  "
  attr_reader :table

  FilterTable.create
             .register_column(:topic_arns, field: :topic_arn)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    topic_rows = []
    pagination_options = nil
    loop do
      catch_aws_errors do
        @api_response = @aws.sns_client.list_topics(pagination_options)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.topics.map do |topic|
        topic_rows += [{ topic_arn: topic.topic_arn }]
      end
      break unless @api_response.next_token
      pagination_options = { next_token: @api_response.next_token }
    end
    @table = topic_rows
  end
end

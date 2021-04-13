require_relative '../aws_base_resource_mock'

class AwsSnsTopicMock < AwsBaseResourceMock

  def initialize
    super
    @topic = {}
    @attributes = {"TopicArn"=> @aws.any_arn,
                   "KmsMasterKeyId"=> "alias/aws/sns"}
    @topic[:attributes] = @attributes
  end

  def stub_data
    stub_data = []

    topic = {:client => Aws::SNS::Client,
             :method => :get_topic_attributes,
             :data => @topic}

    stub_data += [topic]
  end

  def topic
    @topic
  end
end
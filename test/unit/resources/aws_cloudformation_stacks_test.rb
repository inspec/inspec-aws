require 'helper'
require 'aws-sdk-core'
require 'aws_cloudformation_stacks'
require_relative 'mock/aws_cloudformation_stack_mock'

class AwsCloudFormationStacksConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsCloudformationStacks.new(client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudformationStacks.new(rubbish: 9) }
  end

end

class AwsCloudFormationStacksTest < Minitest::Test

  def setup
    # create a number of mock stacks
    number_of_mock = 5
    @mock = AwsCloudFormationStackMock.new.multiple(number_of_mock)

    #create stub data
    data = {}
    data[:data] = { :stacks => @mock }
    data[:client] = Aws::CloudFormation::Client
    data[:method] = :describe_stacks
    
    #create a number of stub stacks with mock data
    @cf = AwsCloudformationStacks.new(
                                 client_args: { stub_responses: true },
                                 stub_data:[data])
  end
  
  def test_stack_name
    @cf.names.zip(@mock).each do |cf_s, m_s|
    assert_equal(cf_s, m_s[:stack_name])
    end
  end

  def test_exists
    assert @cf.exists?
  end
end

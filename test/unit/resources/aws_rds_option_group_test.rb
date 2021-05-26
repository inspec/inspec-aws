require 'helper'
require 'aws_rds_option_group'
require 'aws-sdk-core'

class AwsRdsOptionGroupConstructorTest < Minitest::Test

  def test_non_empty_params_ok
    AwsRdsOptionGroup.new(option_group_name: 'default:aurora-5-6', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsRdsOptionGroup.new(option_gpp:'rubbish') }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsRdsOptionGroup.new(rubbish: 9) }
  end
end

class AwsRdsOptionGroupHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_option_groups
    mock_option_groups = {}
    mock_option_groups[:option_group_name] = 'default:aurora-5-6'
    mock_option_groups[:option_group_description] = 'Default option group for aurora 5.6'
    mock_option_groups[:engine_name] = 'aurora'
    mock_option_groups[:major_engine_version] = '5.6'
    mock_option_groups[:option_group_arn] = 'arn:aws:rds:us-east-2:112758395563:og:default:aurora-5-6'
    mock_option_groups[:allows_vpc_and_non_vpc_instance_memberships] = true
    data[:data] = { :option_groups_list => [mock_option_groups] }
    data[:client] = Aws::RDS::Client
    @option_group = AwsRdsOptionGroup.new(option_group_name: 'default:aurora-5-6',client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_option_group_names
    assert_equal(@option_group.option_group_name, 'default:aurora-5-6')
  end

  def test_option_group_name_exists
    assert @option_group.exists?
  end

  def test_option_group_name_available
    assert @option_group.available?
  end

  def test_option_group_engine_name
    assert_equal(@option_group.engine_name, 'aurora')
  end

  def test_option_group_arn
    assert_equal(@option_group.option_group_arn, 'arn:aws:rds:us-east-2:112758395563:og:default:aurora-5-6')
  end
  
end



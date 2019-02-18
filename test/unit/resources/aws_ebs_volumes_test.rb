require 'helper'
require 'aws_ebs_volumes'
require 'aws-sdk-core'

class AwsEbsVolumesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsEbsVolumes.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsEbsVolumes.new('rubbish') }
  end

  def test_volumes_non_existing_for_empty_response
    refute AwsEbsVolumes.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsEbsVolumesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_volumes
    mock_volume = {}
    mock_volume[:volume_id] = 'vol-012b75749d0b5ceb5'
    data[:data] = { :volumes => [mock_volume] }
    data[:client] = Aws::EC2::Client
    @volumes = AwsEbsVolumes.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_volumes_exists
    assert @volumes.exist?
  end

  def test_volumes_ids
    assert_equal(@volumes.volume_ids, ['vol-012b75749d0b5ceb5'])
  end

  def test_volumes_filtering_not_there
    refute @volumes.where(:volume_id => 'bad').exist?
  end

  def test_volumes_filtering_there
    assert @volumes.where(:volume_id => 'vol-012b75749d0b5ceb5').exist?
  end
end
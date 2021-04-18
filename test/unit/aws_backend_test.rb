require 'helper'

class AwsBackendTest < Minitest::Test
  def test_any_object_responds_to_blank?
    assert_respond_to(Object, :blank?)
  end
end

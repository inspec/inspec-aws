require 'helper'

class ObjectTest < Minitest::Test
  def test_any_object_responds_to_blank?
    assert_respond_to(Object, :blank?)
  end

  def test_empty_string_with_blank?
    assert(''.blank?)
  end

  def test_nil_with_blank?
    assert(nil.blank?)
  end

  def test_empty_array_with_blank?
    assert([].blank?)
  end

  def test_empty_hash_with_blank?
    assert({}.blank?)
  end

  def test_any_object_responds_to_present?
    assert_respond_to(Object, :present?)
  end

  def test_any_object_responds_to_presence
    assert_respond_to(Object, :presence)
  end

  def test_presence_returns_object
    assert_equal('test_string'.presence, 'test_string')
  end
end

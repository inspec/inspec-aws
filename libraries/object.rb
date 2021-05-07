# frozen_string_literal: true

class Object
  # An object is blank if it's false, empty, or a whitespace string.
  # For example, nil, "", '', [], {}, and false are all blank
  def blank?
    respond_to?(:empty?) ? !!empty? : !self
  end

  # An object is present if it's not blank.
  def present?
    !blank?
  end

  # Returns the receiver if it's present otherwise returns nil
  def presence
    self if present?
  end
end

class RgbValidator < ActiveModel::EachValidator
  VALID_RGB_REGEX = /\Argb\(\d{1,3}, ?\d{1,3}, ?\d{1,3}\)\z/i

  def validate_each record, attribute, value
    unless value =~ VALID_RGB_REGEX
      record.errors[attribute] << (options[:message] || "is invalid")
    end
  end

end
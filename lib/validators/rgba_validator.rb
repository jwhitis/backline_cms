class RgbaValidator < ActiveModel::EachValidator
  VALID_RGBA_REGEX = /\Argba\(\d{1,3}, ?\d{1,3}, ?\d{1,3}, ?(?:1|0(?:\.\d{1,2})?)\)\z/i

  def validate_each record, attribute, value
    unless value =~ VALID_RGBA_REGEX
      record.errors[attribute] << (options[:message] || "is invalid")
    end
  end

end
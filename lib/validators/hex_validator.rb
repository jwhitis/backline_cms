class HexValidator < ActiveModel::EachValidator
  VALID_HEX_REGEX = /\A(?:#\h{6}|#\h{3})\z/

  def validate_each record, attribute, value
    unless value =~ VALID_HEX_REGEX
      record.errors[attribute] << (options[:message] || "is invalid")
    end
  end

end
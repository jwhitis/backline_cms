class HexCodeValidator < ActiveModel::EachValidator
  VALID_HEX_CODE_REGEX = /\A(?:#[a-fA-F0-9]{6}|#[a-fA-F0-9]{3})\z/

  def validate_each record, attribute, value
    unless value =~ VALID_HEX_CODE_REGEX
      record.errors[attribute] << (options[:message] || "is invalid")
    end
  end

end
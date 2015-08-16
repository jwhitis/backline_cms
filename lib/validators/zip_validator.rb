class ZipValidator < ActiveModel::EachValidator
  VALID_ZIP_REGEX = /\A\d{5}(?:-\d{4})?\z/

  def validate_each record, attribute, value
    unless value =~ VALID_ZIP_REGEX
      record.errors[attribute] << (options[:message] || "is invalid")
    end
  end

end
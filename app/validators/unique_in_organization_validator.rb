# frozen_string_literal: true

class UniqueInOrganizationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :on_blacklist) if blacklist.include? value
  end

  private

  def organization; end
end

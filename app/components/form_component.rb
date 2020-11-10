class FormComponent < ReflexComponent
  include FormHelpers

  attr_reader :record

  def initialize(record: nil, options: {})
    @record = record
    @options = options
  end
end

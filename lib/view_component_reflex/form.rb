module ViewComponentReflex::Form
  include ViewComponentReflex::Form::DateInputs
  include ViewComponentReflex::Form::FileInputs
  include ViewComponentReflex::Form::FormHelpers
  include ViewComponentReflex::Form::Inputs
  include ViewComponentReflex::Form::LocationInputs
  include ViewComponentReflex::Form::PhoneInputs
  include ViewComponentReflex::Form::Reflexes
  include ViewComponentReflex::Form::ReflexHelpers
  include ViewComponentReflex::Form::Selects
  include ViewComponentReflex::Form::MoneyInputs

  INPUT_MAPPINGS = {
    string: :text_input,
    text: :textarea_input,
    rich_text: :rich_text_input,
    association: :association_select,
    select: :select,
    integer: :number_input,
    color: :color_input,
    boolean: :check_box,
    date: :date_input,
    day: :day_select,
    dropdown: :dropdown_select,
    country: :country_code_select,
    city: :city_select,
    phone_country_code: :phone_country_code_select,
    phone_number: :phone_number_input,
    phone: :phone_input,
    attachments: :file_input,
    file: :file_input,
    email: :email_input,
    money: :money_input
  }.with_indifferent_access.freeze

  attr_reader :record
end

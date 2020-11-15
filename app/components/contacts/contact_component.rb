class Contacts::ContactComponent < ApplicationComponent
  def initialize(contact:)
    @contact = contact
  end
end

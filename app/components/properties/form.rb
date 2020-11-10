class Properties::Form < ReflexComponent
  def initialize(property:)
    @property = property
  end

  def allow_select_enterprise?
    !params.key?(:enterprise_id)
  end

  def form_path
    @property.persisted? ? property_url(@property) : url_for(controller: controller_name, action: :create)
  end

  def submit_copy
    @property.persisted? ? 'Salvar mudanças' : 'Adicionar propriedade'
  end

  def toggle_belongs_to_third_party
    @belongs_to_third_party = !@belongs_to_third_party
  end

  def belongs_to_third_party?
    @belongs_to_third_party ||= false || (@property.persisted? && @property.owner.present?)
  end

  def toggle_belongs_to_enterprise
    @belongs_to_enterprise = !@belongs_to_enterprise
  end

  def belongs_to_enterprise?
    @belongs_to_enterprise ||= false || (@property.persisted? && @property.enterprise.present?)
  end

  def before_render
    @owner_options = @property.owners_from_type
    @property.owner_id = @owner_options&.first&.id
  end

  def update_owner_type
    @property.assign_attributes property_params
  end

  def update_owner_id
    @property.assign_attributes property_params
  end

  def property_types_collection
    Property::TYPES.map do |type|
      [type, ['Properties', type].join('::')]
    end
  end

  private

  def property_params
    return {} unless params.key? :property

    params.require(:property).permit(
      :name, :code, :default_charges_cents, :default_charges_currency, :market_value_cents,
      :market_value_currency, :default_rent_cents, :default_rent_currency, :type, :typology,
      :photos, :description, :cover_photo, :owner_id, :owner_type, :enterprise_id,
      address_attributes: %i[street door floor city country zip_code]
    )
  end
end

module ViewComponentReflex::Form::Reflexes
  def update_field
    before_update_field
    attribute = _attribute_from_input_name(element.name)
    value = element.value || params.dig(_record_name, attribute)

    @record.assign_attributes(attribute => value)
    after_update_field if @record.send(attribute) == value

    @record.save if element.dataset.save
  end

  def save
    before_save
    if @record.save
      after_save
      render_toast(success: t('alerts.changes_saved_successfully'))
    else
      render_toast(error: t('alerts.could_not_save_record'))
    end
  end

  def upload_file
    before_update_field

    attribute = _attribute_from_input_name(element.name)
    value = element.value || params.dig(_record_name, attribute)

    blob = ActiveStorage::Blob.create_after_upload!(
      io: StringIO.new((Base64.decode64(value.split(',').last))),
      filename: 'user.png',
      content_type: 'image/png'
    )
    after_update_field if @record.send(attribute).attach(blob)
  end

  def after_save; end

  def before_save; end

  def after_update_field; end

  def before_update_field; end
end

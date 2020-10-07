module ImageHelper
  def avatar_image_tag(record)
    return image_tag(record.contact.avatar, class: 'avatar') if record.contact&.avatar&.attached?

    inline_svg_pack_tag('media/icons/person-circle.svg', class: 'avatar icon-muted')
  end
end

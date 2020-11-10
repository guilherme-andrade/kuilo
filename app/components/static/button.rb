class Static::Button < ApplicationComponent
  attr_reader :icon, :to, :size, :semantic, :options

  SIZE_CLASSES = {
    block: 'btn d-block',
    lg: 'btn btn-lg',
    sm: 'btn btn-sm',
    default: 'btn'
  }.with_indifferent_access.freeze

  TYPE_CLASSES = {
    delete: 'btn-danger',
    edit: 'btn-warning',
    comment: 'btn-black',
    default: 'btn-primary',
    light: 'btn-light',
    round: 'btn-round',
    back: 'btn-round btn-light',
    add: 'btn-primary',
    back_link: 'btn-link'
  }.with_indifferent_access.freeze

  TYPE_ICONS = {
    delete: 'trash',
    comment: 'chat-left-text',
    edit: 'pencil',
    add: 'plus',
    back: 'arrow-left',
    back_link: 'arrow-left'
  }.with_indifferent_access.freeze

  TYPE_TEXT = {
    delete: I18n.t('globals.delete'),
    edit: I18n.t('globals.edit'),
    comment: I18n.t('globals.comments'),
    back: I18n.t('globals.go_back'),
    add: I18n.t('globals.add'),
    back_link: I18n.t('globals.go_back')
  }.with_indifferent_access.freeze

  def initialize(to: '#', size: 'default', type: 'default', **options)
    @size = size
    @type = type
    @text = text
    @to = to
    @options = options
    @icon = options.delete(:icon)
    @text = options.delete(:text)
    @signal = options.delete(:signal)
  end

  private

  def text
    return @text if @text.is_a?(String)

    @text && TYPE_TEXT[@type]
  end

  def icon_svg
    opts = {}
    opts[:class] = 'ml-2' if @text
    @icon ||= icon_from_type unless @icon == false

    inline_svg_pack_tag "media/icons/#{@icon}.svg", opts
  end

  def classes
    [].yield_self do |classes_array|
      classes_array.concat(signal_classes) if signal?
      classes_array.concat([options.dig(:class)])
      classes_array.concat(size_classes)
      classes_array.concat(type_classes)
    end
  end

  def size_classes
    size_args = @size.to_s.split(' ')

    size_args.map { |arg| SIZE_CLASSES[arg] }
  end

  def type_classes
    type_args = @type.to_s.split(' ')

    type_args.map { |arg| TYPE_CLASSES[arg] }
  end

  def icon_from_type
    @type.to_s.split(' ').find { |type| TYPE_ICONS.key?(type) }.yield_self do |main_type|
      TYPE_ICONS[main_type]
    end
  end

  def tooltip_attributes
    content = @options.delete(:tooltip)
    return {} unless content

    { title: content, data: { toggle: 'tooltip', placement: 'top' } }
  end

  def signal_classes
    %w[signal signal-notification signal-notification-primary]
  end

  def signal?
    @signal
  end
end

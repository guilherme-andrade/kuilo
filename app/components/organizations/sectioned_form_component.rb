class Organizations::SectionedFormComponent < ApplicationComponent
  def initialize(organization:)
    @organization = organization
    @active_tab = tabs.first
    @completed_tabs = []
  end

  def before_render
    @organization.build_address if @organization.address.blank?
    @organization.build_contact if @organization.contact.blank?
    @organization.build_bank_account if @organization.bank_account.blank?
  end

  def mark_as_completed!
    @completed_tabs << @active_tab
  end

  def change_tab
    tabs.find { |tab| tab[:name] == element.dataset.tab.to_sym }.tap do |new_tab|
      @active_tab = new_tab if new_tab
    end
  end

  def tab_icon_for(tab)
    return unless tab[:icon]

    inline_svg_pack_tag ['media/icons/', tab[:icon], '.svg'].join, class: 'icon icon-sm mr-2'
  end

  def tab_signal_for(tab)
    if @completed_tabs.include?(tab)
      content_tag(:span, '', class: 'signal signal-success')
    else
      content_tag(:span, '', class: 'signal signal-muted')
    end
  end

  def tab_class_for(tab)
    ['list-group-link'].tap { |classes| classes << 'active' if @active_tab == tab }
  end

  def tab_content
    @active_tab[:component].new(@active_tab[:payload])
  end

  def details_tab?
    @active_tab[:name] == :details
  end

  def address_tab?
    @active_tab[:name] == :address
  end

  def bank_account_tab?
    @active_tab[:name] == :bank_account
  end

  def contact_tab?
    @active_tab[:name] == :contact
  end

  # rubocop:disable Metric/MethodLength
  def tabs
    [
      {
        text: I18n.t('components.organizations.form.details'),
        icon: 'shield-fill-check',
        name: :details,
        component: Organizations::Form::DetailsSectionComponent,
        payload: {
          record: @organization,
          options: {
            title: I18n.t('components.organizations.form.details_title'),
            subtitle: I18n.t('components.organizations.form.details_subtitle')
          }
        }
      },
      {
        text: I18n.t('components.organizations.form.bank_account'),
        icon: 'wallet-fill',
        name: :bank,
        component: BankAccounts::NestedFormComponent,
        payload: {
          record: @organization.bank_account,
          options: {
            title: I18n.t('components.organizations.form.bank_account_title'),
            subtitle: I18n.t('components.organizations.form.bank_account_subtitle')
          }
        }
      },
      {
        text: I18n.t('components.organizations.form.contact'),
        icon: 'person-lines-fill',
        name: :contact,
        component: Contacts::NestedFormComponent,
        payload: {
          record: @organization.contact,
          options: {
            title: I18n.t('components.organizations.form.contact_title'),
            subtitle: I18n.t('components.organizations.form.contact_subtitle')
          }
        }
      },
      {
        text: I18n.t('components.organizations.form.address'),
        icon: 'geo-fill',
        name: :address,
        component: Addresses::NestedFormComponent,
        payload: {
          record: @organization.address,
          options: {
            title: I18n.t('components.organizations.form.address_title'),
            subtitle: I18n.t('components.organizations.form.address_subtitle')
          }
        }
      }
    ]
  end
  # rubocop:enable Metric/MethodLength
end

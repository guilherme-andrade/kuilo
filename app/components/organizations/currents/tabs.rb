class Organizations::Currents::Tabs < ApplicationComponent
  def tabs
    [
      { text: t('globals.manage'), path: current_organization_path },
      { text: t('globals.members'), path: current_organization_members_path },
      { text: t('globals.settings'), path: edit_current_organization_path }
    ]
  end
end

class Properties::SidebarExtension::EnterpriseComponent < ReflexComponent
  attr_reader :enterprise

  def initialize(enterprise:)
    @enterprise = enterprise
  end
end

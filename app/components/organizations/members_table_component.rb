class Organizations::MembersTableComponent < ReflexComponent
  include ImageHelper

  def initialize(organization:)
    @organization = organization
    @memberships = organization.memberships
    @show_member_form = false
  end

  def toggle_member_form
    @show_member_form = !@show_member_form
    return unless show_member_form?

    @new_member = User.new
    @new_member.build_contact
    @new_member.memberships.build(organization: @organization)
  end

  def show_member_form?
    @show_member_form
  end

  def change_role
    id = element.dataset.id
    role = element.dataset.role
    membership = @organization.memberships.find(id)

    membership.update(role: role)
  end
end

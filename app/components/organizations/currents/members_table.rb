class Organizations::Currents::MembersTable < ReflexComponent
  include ImageHelper

  def initialize(organization:)
    @organization = organization
    @memberships = organization.memberships.includes(user: { contact: :avatar_attachment })
    @show_member_form = false
  end

  def toggle_member_form
    @show_member_form = !@show_member_form

    if show_member_form?
      initialize_new_member
    else
      reload_memberships
    end
  end

  def close_form
    @show_member_form = false
  end

  def add_member
    return unless invite_member

    close_form
    reload_memberships
    flash(success: 'Convite enviado com sucesso')
  end

  def change_role
    id = element.dataset.id
    role = element.dataset.role
    membership = @organization.memberships.find(id)

    membership.update(role: role)
    @memberships.reload
  end

  def invite_member
    current_organization.invite_member(
      role: params[:role],
      email: params[:email],
      name: params[:name],
      invited_by: current_user
    )
  end

  def show_member_form?
    @show_member_form
  end

  def reload_memberships
    @memberships.reload
  end

  def initialize_new_member
    @new_member = User.new
    @new_member.build_contact
    @new_member.memberships.build(organization: @organization)
  end
end

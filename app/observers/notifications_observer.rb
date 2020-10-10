class NotificationsObserver < ApplicationObserver
  observe :property, :contract, :comment, :transaction,
          :enterprise, :organization_member, :organization

  def after_create(record)

  end
end

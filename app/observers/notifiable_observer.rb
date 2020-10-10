class NotifiableObserver < ApplicationObserver
  observe :property, :contract, :comment, :transaction,
          :enterprise, :organization_member, :organization

  attr_reader :record

  delegate :class, to: :record, prefix: true
  delegate :creator, to: :record, prefix: true, allow_nil: true
  delegate :organization_members, to: :record, allow_nil: true

  def after_create(record)
    @record = record

    deliver_notification
  end

  def deliver_notification
    comment_notification_class.with(notifiable: self).deliver(recipients)
  end

  def recipients
    case record
    when Comment then record.mentions
    when record_creator.nil? then organization_members
    else organization_members.where.not(id: record_creator.id)
    end
  end

  def comment_notification_class
    [record_class, 'Notification'].join.constantize
  end
end

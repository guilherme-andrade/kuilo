class NotifiableSubscriber < ApplicationSubscriber
  attr_reader :record

  delegate :class, to: :record, prefix: true
  delegate :creator, to: :record, prefix: true, allow_nil: true
  delegate :organization_members, to: :record, allow_nil: true

  def after_create(record)
    @record = record

    deliver_notification if notifiable_notification_class_defined?
  end

  private

  def deliver_notification
    notifiable_notification_class.constantize.with(notifiable: record).deliver(recipients)
  end

  def recipients
    case record
    when Comment then record.mentions
    when record_creator.nil? then organization_members
    else organization_members.where.not(id: record_creator.id)
    end
  end

  def notifiable_notification_class
    [record_class, 'Notification'].join
  end

  def notifiable_notification_class_defined?
    Object.const_defined?(notifiable_notification_class)
  end
end

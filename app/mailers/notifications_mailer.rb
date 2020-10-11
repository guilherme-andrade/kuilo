class NotificationsMailer < ApplicationMailer
  before_action :find_notifiable
  after_action :send_email

  def default
  end

  def comment
    @comment = @notifiable
    @subject = t('emails.you_were_mentioned')
  end

  def next_rents_created
    @url = notification_params[:url]
    @subject = t('emails.next_rents_created')
    @rents = Rent.find(params[:rent_ids])
  end

  def contract_status_changed
    @contract = @notifiable
    @message = notification_params[:message]
    @subject = t("emails.a_contract_is_now_#{@contract.status}")
  end

  private

  def send_email
    mail(to: @recipient.email, subject: @subject )
  end

  def notification_params
    @notification_params ||= @notification.params
  end

  def find_notifiable
    @notification = params[:record]
    @recipient  = params[:recipient]
    @notifiable = @notification.notifiable
  end
end

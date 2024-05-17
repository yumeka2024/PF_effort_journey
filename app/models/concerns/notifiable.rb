# app/models/concerns/notifiable.rb
module Notifiable
  extend ActiveSupport::Concern

  included do
    after_commit :create_notification_on_create, on: :create, if: :notification_needed?
  end

  def notification_needed?
    raise NotImplementedError, "You must implement notification_needed? in your model"
  end

  private

  def create_notification_on_create
    create_notification(notification_message_type)
  end

  def create_notification(message_type)
    Notification.create(
      user_id: notification_user_id,
      post: notification_post,
      sender: notification_sender,
      message: message_type
    )
  end

  def notification_message_type
    raise NotImplementedError, "You must implement notification_message_type in your model"
  end

  def notification_user_id
    raise NotImplementedError, "You must implement notification_user_id in your model"
  end

  def notification_post
    raise NotImplementedError, "You must implement notification_post in your model"
  end

  def notification_sender
    raise NotImplementedError, "You must implement notification_sender in your model"
  end
end

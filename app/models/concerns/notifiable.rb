module Notifiable
  extend ActiveSupport::Concern

  included do
    after_commit :notify_create, on: :create
  end

  private

  def notify_create
    create_notification
  rescue => e
    Rails.logger.error "Notification creation failed for #{self.class.name} with ID #{self.id}: #{e.message}"
    raise ActiveRecord::Rollback
  end

  def create_notification
    Notification.create!(
      user_id: notification_user_id,
      post_id: notification_post_id,
      sender_id: notification_sender_id,
      notifiable: self,
      message: notification_message
    )
  end

  def notification_user_id
    case self
    when Like, Comment
      post&.user_id
    when Relationship
      followed_id
    end
  end

  def notification_post_id
    case self
    when Like, Comment
      post_id
    when Relationship
      nil
    end
  end

  def notification_sender_id
    case self
    when Like, Comment
      user_id
    when Relationship
      follower_id
    end
  end

  def notification_message
    case self
    when Like
      3
    when Comment
      4
    when Relationship
      approved? ? 0 : 1
    end
  end
end

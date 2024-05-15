# app/models/concerns/notifiable.rb
require 'active_support'

module Notifiable
  extend ActiveSupport::Concern
  include Rails.application.routes.url_helpers

  def notification_message(current_user)
    raise NotImplementedError
  end

  def notification_path(current_user)
    raise NotImplementedError
  end
end

class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.greeting.subject
  #
  def greeting
    @greeting = "Hi"

    mail to: ENV['MAILER_TEST_TO']
  end
end

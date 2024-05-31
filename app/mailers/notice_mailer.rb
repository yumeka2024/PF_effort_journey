class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.greeting.subject
  #
  def greeting(user)
    @user = user
    mail(
    to: user.email,
    subject: "effort journeyへようこそ！"
    )
  end

  def notice(notice)
    @notice = notice
    mail(
    to: notice.user.email,
    subject: "#{notice.sender.name}#{notice.message_i18n}"
    )
  end

  def farewell(user)
    @user = user
    mail(
    to: user.email,
    subject: "退会が完了しました"
    )
  end

end

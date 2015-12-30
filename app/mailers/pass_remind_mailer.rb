class PassRemindMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.pass_remind_mailer.PassRemindSender.subject
  #
  def pass_remind_user(email)
    
    @greeting = "Hi"
    mail to: email, subject: 'パスワードリマインダー。'
    
  end
  
end

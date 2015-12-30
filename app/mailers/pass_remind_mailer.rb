class PassRemindMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.pass_remind_mailer.PassRemindSender.subject
  #
  def pass_remind_user(user,token)
    
    @user = user
    @url  = "http://ik1-301-10815.vs.sakura.ne.jp:3030/pass_token_user/#{token}"
    mail to: user.email, subject: 'パスワードリマインダー。'
    
  end
  
end

class RegistConfirmMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.regist_confirm_mailer.sender.subject
  #
  def regist_confirm(user,token)
    @user = user
    @url  = "http://ik1-301-10815.vs.sakura.ne.jp:3030/users/#{user.id}/regist_token/#{token}"
    mail to: user.email, subject: '【*******】アカウントの本登録をお願いします'
  end

  def regist_complet(user)
    @user = user
    @url  = "http://ik1-301-10815.vs.sakura.ne.jp:3030"
    mail to: user.email, subject: '【*******】登録完了のお知らせ。'
  end

end

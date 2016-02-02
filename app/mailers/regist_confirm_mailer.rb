class RegistConfirmMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.regist_confirm_mailer.sender.subject
  #
  def regist_confirm_user(user,token)
    @user = user
    @url  = "http://ik1-301-10815.vs.sakura.ne.jp:3030/regist_token_user/#{token}"
    mail to: user.email, subject: '【ゲーム☆ニクス】アカウントの本登録をお願いします'
  end

  def regist_complet_user(user)
    @user = user
    @url  = "http://ik1-301-10815.vs.sakura.ne.jp:3030"
    mail to: user.email, subject: '【ゲーム☆ニクス】登録完了のお知らせ。'
  end

  def regist_confirm_dev(developer,token)
    @developer = developer
    @url  = "http://ik1-301-10815.vs.sakura.ne.jp:3030/regist_token_dev/#{token}"
    mail to: developer.email, subject: '【ゲーム☆ニクス】アカウントの本登録をお願いします'
  end

  def regist_complet_dev(developer)
    @developer = developer
    @url  = "http://ik1-301-10815.vs.sakura.ne.jp:3030"
    mail to: developer.email, subject: '【ゲーム☆ニクス】登録完了のお知らせ。'
  end

end

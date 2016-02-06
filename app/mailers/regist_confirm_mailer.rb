class RegistConfirmMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.regist_confirm_mailer.sender.subject
  #
  def regist_confirm_user(user,token)
    @user = user
    case Rails.env
      when 'development'
        @url  = "http://ik1-301-10815.vs.sakura.ne.jp:3030/regist_token_user/#{token}"
      when 'production'
        @url  = "http://www.gamenist.com/regist_token_user/#{token}"
    end    
    mail to: user.email, subject: '【ゲーム☆ニスト】アカウントの本登録をお願いします'
  end

  def regist_complet_user(user)
    @user = user
    case Rails.env
      when 'development'
        @url  = "http://ik1-301-10815.vs.sakura.ne.jp:3030"
      when 'production'
        @url  = "http://www.gamenist.com"
    end    
    mail to: user.email, subject: '【ゲーム☆ニスト】登録完了のお知らせ。'
  end

  def regist_confirm_dev(developer,token)
    @developer = developer
    case Rails.env
      when 'development'
        @url  = "http://ik1-301-10815.vs.sakura.ne.jp:3030/regist_token_dev/#{token}"
      when 'production'
        @url  = "http://www.gamenist.com/regist_token_dev/#{token}"
    end    
    mail to: developer.email, subject: '【ゲーム☆ニスト】アカウントの本登録をお願いします'
  end

  def regist_complet_dev(developer)
    @developer = developer
    case Rails.env
      when 'development'
        @url  = "http://ik1-301-10815.vs.sakura.ne.jp:3030"
      when 'production'
        @url  = "http://www.gamenist.com"
    end    
    mail to: developer.email, subject: '【ゲーム☆ニスト】登録完了のお知らせ。'
  end

end

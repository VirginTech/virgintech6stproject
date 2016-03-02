class AdminMailer < ApplicationMailer
  
  def user_mail_info(user, mail_body)
    @user=user
    @mail_body=mail_body
    mail to:@user.email, subject: "【ゲームニスト運営事務局より】ユーザーの皆様へ（ご連絡）"
  end

  def dev_mail_info(developer, mail_body)
    @developer=developer
    @mail_body=mail_body
    mail to:@developer.email, subject: "【ゲームニスト運営事務局より】デベロッパーの皆様へ（ご連絡）"
  end
  
  def product_mail_info(user,products)
    @user=user
    @products=products
    mail to: @user.email, subject: "【ゲーム☆ニスト】おすすめ新着ゲームアプリ"
  end
  
end
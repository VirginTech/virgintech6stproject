class AdminMailer < ApplicationMailer
  
  def product_mail_info(user,products)
    @user=user
    @products=products
    mail to: @user.email, subject: "【ゲーム☆ニスト】おすすめ新着ゲームアプリ"
  end
  
end
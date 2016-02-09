class DocsController < ApplicationController
  
  def contact_feedback
    
    if params[:email].present? && params[:subject].present? && params[:text_body].present?
    
      @name=params[:name];
      @email=params[:email];
      @subject=params[:subject];
      @text_body=params[:text_body];
    
      # メール送信
      @mail = ContactMailer.contact_feedback(@name,@email,@subject,@text_body).deliver
      flash[:success] = "お問い合わせ誠にありがとうございました。"
      redirect_to contact_path
  
    else

      flash[:danger] = "送信に失敗しました。全ての項目を入力して下さい。"
      redirect_to contact_path
      
    end
  
  end
  
  
  
  def about_site
  end

  def terms
  end
  
  def privacypolicy
  end

  def contact
  end

  def faq
  end

  def developer_s
  end

  def advertising
  end
  
  def notice
  end
  
end
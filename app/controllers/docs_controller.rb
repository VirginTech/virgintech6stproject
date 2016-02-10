class DocsController < ApplicationController
  
  def notification
    if params[:text_body].present?
      @name=params[:name];
      @email=params[:email];
      @text_body=params[:text_body];
      @comment_id=params[:comment_id];
      @comment_body=params[:comment_body];
      # メール送信
      @mail = ContactMailer.notification(@name,@email,@text_body,@comment_id,@comment_body).deliver
      flash[:success] = "通報していただき誠にありがとうございました。"
      redirect_to session[:forwarding_url]
    else
      flash[:danger] = "通報に失敗しました。内容を入力して下さい。"
      redirect_to session[:forwarding_url]
    end
  end

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
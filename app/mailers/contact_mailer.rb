class ContactMailer < ApplicationMailer
  
  def notification(name,email,text_body,comment_id,comment_body)
    @name=name
    @email=email
    @text_body=text_body
    @comment_id=comment_id
    @comment_body=comment_body
    mail to: 'info@gamenist.com', subject: "【通報】コメントNo: #{@comment_id}"
  end
  
  def contact_feedback(name,email,subject,text_body)
    @name=name
    @email=email
    @subject=subject
    @text_body=text_body
    mail to: 'info@gamenist.com', subject: "【お問い合わせ】#{@subject}"
  end
  
end

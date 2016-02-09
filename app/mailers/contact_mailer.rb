class ContactMailer < ApplicationMailer
  
  def contact_feedback(name,email,subject,text_body)
    
    @name=name
    @email=email
    @subject=subject
    @text_body=text_body
    
    mail to: 'info@gamenist.com', subject: "【お問い合わせ】#{@subject}"
  end
  
end

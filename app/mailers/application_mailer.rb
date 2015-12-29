class ApplicationMailer < ActionMailer::Base
  # default from: "from@example.com"
  default from: Rails.application.secrets.gmail_account_id
  layout 'mailer'
end

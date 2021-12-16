class ApplicationMailer < ActionMailer::Base
  default from: 'alodokter.confirmation@gmail.com'
  layout 'mailer'
end

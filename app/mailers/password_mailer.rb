class PasswordMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.forget.subject
  #
  def forget
    @token = params[:user].signed_id(purpose: "password_forget", expires_in: 15.minutes)
    mail to: params[:user].email, subject: "Lupa Password Alodokter"
  end
end

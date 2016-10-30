class UserMailer < ApplicationMailer
  default from: 'info@proyectoalimentar.org'

  def welcome_email(user)
    @user = user
    @url  = 'proyectoalimentar.org'
    mail(to: @user.email, subject: 'Bienvenido a Proyecto Alimentar')
  end
end

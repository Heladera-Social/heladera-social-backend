class UserMailer < ApplicationMailer
  default from: 'info@proyectoalimentar.org'

  def welcome_email(user)
    @user = user
    @url  = 'proyectoalimentar.org'
    mail(to: @user.email, subject: 'Bienvenido a Proyecto Alimentar')
  end

  def welcome_contact_email(contact)
    @contact = contact
    @url  = 'proyectoalimentar.org'
    mail(to: @contact.email, subject: 'Bienvenido a Proyecto Alimentar')
  end

  def new_contact_manager(contact)
    @contact = contact
    @url  = 'proyectoalimentar.org'
    mail(to: Rails.application.secrets.email_token, subject: 'Nuevo Magener: Bienvenido a Proyecto Alimentar')
  end
end

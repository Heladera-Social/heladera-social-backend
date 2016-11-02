class ExpirationMailer < ApplicationMailer
  default from: 'info@proyectoalimentar.org'

  def expiration(user, product)
    @user = user
    @product = product
    @url  = 'proyectoalimentar.org'
    mail(to: @user.email, subject: 'Un producto se esta por vencer')
  end

end

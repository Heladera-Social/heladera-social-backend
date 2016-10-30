class Contact < ActiveRecord::Base
  validates :email, :first_name, :last_name, presence: true

  after_create :welcome_contact_email

  def welcome_contact_email
    UserMailer.welcome_contact_email(self).deliver
    UserMailer.new_contact_manager(self).deliver
  end
end

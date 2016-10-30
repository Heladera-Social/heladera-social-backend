class Contact < ActiveRecord::Base
  validates :email, :first_name, :last_name, presence: true

  after_create :send_email

  def send_email
  end
end

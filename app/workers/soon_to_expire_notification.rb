class SoonToExpireNotification

  include Sidekiq::Worker

  def perform
    products = Product.expires_in(5)
    products.each do |p|
    	ExpirationMailer.delay_for(10.seconds).expiration(p.storage_unit.managers.first, p)
    end
  end
end
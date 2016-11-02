desc "Enviar mails con productos prontos a vencer"
task :expiration_worker => :environment do
  puts "Enviando mails"
  SoonToExpireNotification.new.perform
  puts "done."
end
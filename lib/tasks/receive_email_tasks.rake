desc 'check email'
task load_email: :environment do
  # ... set options if any
  ReceivedEmail.check_email
end

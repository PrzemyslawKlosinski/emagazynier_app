require 'smtp_tls'
require 'actionmailer_gmail'

ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :user_name => 'emagazynierapp@gmail.com',
    :password => '!emag2013',
    :authentication => :plain,
    # :enable_starttls_auto => true
  }

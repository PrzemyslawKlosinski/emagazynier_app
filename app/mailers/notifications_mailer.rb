# http://matharvard.ca/posts/2011/aug/22/contact-form-in-rails-3/

class NotificationsMailer < ActionMailer::Base

  	default from: 'eMagazynier_App'
  # default :from => "noreply@youdomain.dev"
  # default :to => "you@youremail.dev"

  def new_message(message, product)
    @message = message
    @product = product

    email_with_name = "#{@message.name} <#{@message.email}>"
    mail(:to => email_with_name, :subject => "Zamowienie ze sklepu #{product.user.name}.")
  end

end
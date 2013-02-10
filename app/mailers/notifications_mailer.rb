# http://matharvard.ca/posts/2011/aug/22/contact-form-in-rails-3/

class NotificationsMailer < ActionMailer::Base

  	default from: 'eMagazyn_App'
  # default :from => "noreply@youdomain.dev"
  # default :to => "you@youremail.dev"

  def new_message(message, product)
    @message = message
    @product = product

    email_with_name = "#{@message.name} <#{@message.email}>"
    mail(:to => email_with_name, :subject => "Zamowienie ze sklepu #{product.user.name}.")
  end

# Found a solution to send a prawn generated pdf as an email attachment. Inside your mailer:
# def new_subscription(user, invoice)
# @invoice = invoice
# pdf = SubscriptionPdf.new(@invoice)
# attachments["invoice.pdf"] = { :mime_type => 'application/pdf', :content => pdf.render }
# mail(:to => user.email, :subject => 'Subscription Receipt', :from => "example@example.com")
# end

end
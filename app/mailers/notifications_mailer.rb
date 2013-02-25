# encoding: utf-8

# http://matharvard.ca/posts/2011/aug/22/contact-form-in-rails-3/

class NotificationsMailer < ActionMailer::Base

  default from: 'eMagazyn_App'
  # default :from => "noreply@youdomain.dev"
  # default :to => "you@youremail.dev"

  def new_message(message, product)
    @message = message
    @product = product


    if @product.isEvent
  		@product_event = "Pracownik: #{@message.worker.name}. Telefon: #{message.worker.phone}"
    	@thankyou = "Dziękujemy za zamówienie. Zapraszamy na wizytę w zaplanowanym terminie."
    	@buydate = "Data realizacji: #{@message.start_at}"
    else
    	@product_event = "Ilość: #{@message.amount}"
    	@thankyou = "Dziękujemy za zamówienie. Po odbiór zapraszamy po 3 dniach od daty zamówienia."
    	@buydate = "Data zamówienia: #{@message.start_at}"
    end
  
    if @message.amount > @product.quantity
      @warning = 'UWAGA: aby to zlecenie mogło zostać zrealizowane prosimy o kontakt telefoniczny.'
    end



    email_with_name = "#{@message.customer} <#{@message.email}>"
    mail(:to => email_with_name, :subject => "Zamówienie ze sklepu #{@product.user.name}.")

  end

# Found a solution to send a prawn generated pdf as an email attachment. Inside your mailer:
# def new_subscription(user, invoice)
# @invoice = invoice
# pdf = SubscriptionPdf.new(@invoice)
# attachments["invoice.pdf"] = { :mime_type => 'application/pdf', :content => pdf.render }
# mail(:to => user.email, :subject => 'Subscription Receipt', :from => "example@example.com")
# end

end
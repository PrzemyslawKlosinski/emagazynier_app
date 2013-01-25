class UserMailer < ActionMailer::Base
  default from: 'eMagazynier_App'


  def welcome_email(user)
    # widocznosc zmiennej user w welcome_email.erb.html
	@user = user
	enc = Base64.encode64(@user.password_digest)
	@url  = "http://0.0.0.0:3000/aktywacja/#{enc}"
    email_with_name = "#{@user.name} <#{@user.email}>"
    mail(:to => email_with_name, :subject => "Witaj w super serwisie eMagazynier")
  end


end

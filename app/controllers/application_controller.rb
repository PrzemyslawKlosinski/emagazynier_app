class ApplicationController < ActionController::Base
  protect_from_forgery

  #dodajemy helper controllera session, dzieki czemu bedzie widoczny na stronie application.html.erb
  #by default, all the helpers are available in the views but not in the controllers.
  include SessionsHelper



end

# Load the rails application
require File.expand_path('../application', __FILE__)

# if ENV['RAILS_ENV'] == "production"
#   ActiveSupport::Deprecation.silenced = true
# end

# Encoding.default_external = Encoding::UTF_8
# Encoding.default_internal = Encoding::UTF_8

# Initialize the rails application
EmagazynierApp::Application.initialize!


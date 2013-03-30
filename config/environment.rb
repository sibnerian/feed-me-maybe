# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
FoodFinder::Application.initialize!


ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['app14249328@heroku.com'],
    :password       => ENV['5lvtybk3'],
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
}
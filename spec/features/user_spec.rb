require 'spec_helper'

describe User do

  it 'requires a name' do
    visit '/users/sign_up'
    fill_in "Email", with: "email@email.com"
    fill_in "Password", with: "password1234"
    fill_in "Password confirmation", with: "password1234"
    click_button "Sign up"
    error_message = "Name can't be blank"
    page.should have_content error_message
  end

end

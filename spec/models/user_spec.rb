require "spec_helper"

describe "New user" do
  it "should not sign up without required fields" do
    robbo = User.new(name:"Robert Paulson")

    expect(robbo.valid?).to eq(false)
  end

  it "should be able to sign up WITH required fields" do
    johnmadden = User.new(name: "john madden", password: "secret", email: "has_an_email@email.com")

    expect(johnmadden.valid?).to eq(true)
  end
end
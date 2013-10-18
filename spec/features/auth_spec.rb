
require 'spec_helper'

describe "the signup process" do
  before(:each) do
    visit new_user_url
  end

  it "has a new user page" do
    expect(page).to have_content("Sign Up")
  end

  describe "signing up a user" do
    before(:each) do
      fill_in 'username', :with => "testing_username"
      fill_in 'password', :with => "ilovecats"
      click_on "Create User"
    end

    it "shows username on the homepage after signup" do
      expect(page).to have_content "testing_username"
    end
  end
end

describe "logging in" do
  before(:all) do
    @user = FactoryGirl.create(:user)
    visit new_session_url
    fill_in 'username', :with => @user.username
    fill_in 'password', :with => "ilovecats"
    click_on "Sign In"
  end

  it "shows username on the homepage after login" do
    expect(page).to have_content @user.username
  end

end

describe "logging out" do

  it "begins with logged out state" do
    visit new_session_url
    expect(page).not_to have_content "Sign Out"
  end

  it "doesn't show username on the homepage after logout" do
    visit new_session_url
    @user = FactoryGirl.create(:user)
    fill_in 'username', :with => @user.username
    fill_in 'password', :with => "ilovecats"
    click_on "Sign In"
    click_on "Sign Out"
    expect(page).not_to have_content @user.username
  end

  it "redirects users to new session after logout" do
    visit new_session_url
    @user = FactoryGirl.create(:user)
    fill_in 'username', :with => @user.username
    fill_in 'password', :with => "ilovecats"
    click_on "Sign In"
    click_on "Sign Out"
    expect(page).to have_content "Sign In"
  end

end

require 'spec_helper'

describe "Cheers" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    visit new_session_url
    fill_in 'username', :with => @user.username
    fill_in 'password', :with => "ilovecats"
    click_on "Sign In"
    @goal = FactoryGirl.create(:goal, :is_private => false)
    visit goal_url(@goal)
  end

  it "has a cheer button" do
    expect(page).to have_button("Cheer")
  end

  it "Allows users to cheer other's goals" do
    click_on "Cheer"
    expect(@goal.cheers.count).to be > 0
  end

  it "Does not allow users to cheer a goal more than once" do
    click_on "Cheer"
    expect(page).to_not have_button("Cheer")
  end

  it "Does not allow user to cheer own goal" do
    @goal = FactoryGirl.create(:goal, :user_id => @user.id)
    visit goal_url(@goal)
    expect(page).to_not have_button("Cheer")
  end

  it "Requires log in" do
    click_on "Sign Out"
    visit goal_url(@goal)
    expect(page).to_not have_button("Cheer")
  end

end

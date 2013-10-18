require 'spec_helper'

describe "the goal creation process" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    visit new_session_url
    fill_in 'username', :with => @user.username
    fill_in 'password', :with => "ilovecats"
    click_on "Sign In"
  end

  it "should have a Create Goal button" do
    expect(page).to have_button("Submit a New Goal")
  end

  describe "creating a new goal" do
    before(:each) do
      click_on "Submit a New Goal"
    end

    it "has a title field" do
      expect(page).to have_content "Title"
    end

    it "has a body field" do
      expect(page).to have_content "Body"
    end

    it "has a private/public option" do
      expect(page).to have_content "Private"
      expect(page).to have_content "Public"
    end

    it "should not have an option to mark the goal as complete" do
      expect(page).not_to have_button "Completed"
    end

    it "should have a button to create goal" do
      expect(page).to have_button "Create Goal"
    end
  end
end

describe "after goal creation" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    visit new_session_url
    fill_in 'username', :with => @user.username
    fill_in 'password', :with => "ilovecats"
    click_on "Sign In"
    click_on "Submit a New Goal"
    fill_in 'title', :with => "Cat Master"
    fill_in 'body', :with => "Have at least 10 cats."
    page.choose('public')
    click_on "Create Goal"
  end

  it "should have the goal title" do
    expect(page).to have_content "Cat Master"
  end

  it "should have the goal body" do
    expect(page).to have_content "Have at least 10 cats."
  end

  it "should have a button to mark completion" do
    expect(page).to have_button "Goal Completed"
  end

  it "should show when the goal is completed" do
    click_on "Goal Completed"
    expect(page).to have_content "#{@user.username} completed this goal!"
  end

  describe "viewing other's goals" do
    before(:each) do
      @goal = FactoryGirl.create(:goal, :user_id => @user.id)
      @other_user = FactoryGirl.create(:user)
      visit new_session_url
      fill_in 'username', :with => @other_user.username
      fill_in 'password', :with => "ilovecats"
      click_on "Sign In"
      visit user_url(@user)
    end

    it "should not allow other users to view private goals" do
      expect(page).not_to have_content("Sour Beer Master")
    end

    it "should allow other users to view public goals" do
      expect(page).to have_content("Cat Master")
    end
  end
end
require 'spec_helper'

describe User do
  it "should have a valid username" do
    FactoryGirl.build(:user, :username => "").should_not be_valid
  end

  it "should have a valid password" do
    FactoryGirl.build(:user, :password => "").should_not be_valid
  end

  it "should have a password of at least 6 characters" do
    FactoryGirl.build(:user, :password => "cats").should_not be_valid
  end

  it "should have a unique username" do
    user = FactoryGirl.create(:user)
    FactoryGirl.build(:user, :username => user.username).should_not be_valid
  end

  it "should have a session token" do
    user = FactoryGirl.create(:user)
    user.session_token.should_not be_nil
  end

  it "should not save the password" do
    user = FactoryGirl.create(:user)
    found_user = User.find_by_username(user.username)
    found_user.password.should be_nil
  end

  it "should be found by User::find_by_credentials" do
    user = FactoryGirl.create(:user)
    User.find_by_credentials(user.username, "ilovecats").should == user
  end

  it "should reset session token correctly" do
    user = FactoryGirl.create(:user)
    old_session_token = user.session_token
    user.reset_session_token!
    old_session_token.should_not == user.session_token
  end

  it { should_not allow_mass_assignment_of(:password_digest) }
  it { should allow_mass_assignment_of(:password) }
  it { should have_many(:goals) }
  it { should have_many(:given_cheers) }
end

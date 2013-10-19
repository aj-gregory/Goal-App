require 'spec_helper'

describe Cheer do

  it "validates goal_id" do
    FactoryGirl.build(:cheer, :goal_id => nil).should_not be_valid
  end

  it "validates user_id" do
    FactoryGirl.build(:cheer, :user_id => nil).should_not be_valid
  end

  it { should belong_to(:user) }
  it { should belong_to(:goal) }
end

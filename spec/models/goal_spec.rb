require 'spec_helper'

describe Goal do

  it "requires a title" do
    FactoryGirl.build(:goal, :title => nil).should_not be_valid
  end

  it "requires a body" do
    FactoryGirl.build(:goal, :body => nil).should_not be_valid
  end

  it { should_not allow_mass_assignment_of(:completed) }
  it { should belong_to :user }
  it { should have_many :cheers }

end

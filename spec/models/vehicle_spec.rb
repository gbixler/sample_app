require 'spec_helper'

describe Vehicle do

  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @vehicle = user.vehicles.build(name: "Lorem ipsum", description: "Lorem ipsum descripto")
  end

  subject { @vehicle }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @vehicle.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank name" do
    before { @vehicle.name = " " }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @vehicle.name = "a" * 141 }
    it { should_not be_valid }
  end
end
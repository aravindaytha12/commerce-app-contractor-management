require 'rails_helper'

RSpec.describe CarrierRecruitment, :type => :model do
  it "has a valid carrier CarrierRecruitment" do
    expect(FactoryGirl.build(:carrier_recruitment)).to be_valid
  end 
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :carrier_recruitment do
    first_name "Jim"
    last_name "Moore"
    address_line "8551 Braxted Ln"
    city "Manassas"
    state "VA"
    zip_code "20110"
    phone_number 7033682189
    email "email@here.com"
    paper_to_deliver "USA Today"
    best_time_to_reach "Anytime"
    how_did_hear "other"
    other_source "None"
    preferred_language "This one"
  end
end

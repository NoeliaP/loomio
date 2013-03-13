# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    admin_email "MyString"
    inviter_id 1
    group_id 1
  end
end

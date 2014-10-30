FactoryGirl.define do
  factory :customer do
    sequence(:email) {|n| "customer#{n}@example.com"}
    sequence(:name)  {|n| "山田#{n}"}
    password  "test0000"
  end
end
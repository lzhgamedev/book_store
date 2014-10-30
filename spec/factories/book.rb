FactoryGirl.define do
  factory :book do
    sequence(:title) {|n| "本#{n}"}
    sequence(:isbn)  {|n| "111111#{n}"}
    price 1000
  end
end
FactoryGirl.define do
  factory :todo do
    task "MyString"
    deadline "2017-09-05"
    completed false
    details "MyText"
  end
end

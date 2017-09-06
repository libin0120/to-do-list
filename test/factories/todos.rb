FactoryGirl.define do
  factory :todo do
    task "My Test ToDo"
    deadline "2018-09-05"
    completed false
    details "My Test DoDo Details"
  end
end

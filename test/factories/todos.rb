FactoryGirl.define do
  factory :todo do
    task "My Test ToDo"
    deadline "2017-09-05"
    completed false
    details "My Test DoDo Details"
  end
end

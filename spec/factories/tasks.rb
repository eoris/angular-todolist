FactoryGirl.define do
  factory :task do
    project
    title "MyString"
    deadline "2016-04-04"
    done false
  end
end

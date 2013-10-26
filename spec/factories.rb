FactoryGirl.define do
  factory :user, aliases: [:owner] do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@oberlin.edu" }
    organization 'Oberlin'
    password 'thisisapassword'
    password_confirmation 'thisisapassword'
    end

  factory :notebook do
    name 'a notebook'
    owner
  end

  factory :page do
    notebook
  end
end

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

  factory :page_template do
    notebook
  end

  factory :tab_group_template do
    page_template
  end

  factory :box_template do
    tab_group_template
    sequence(:name) { |n| "Box Template #{n}" }
  end

  factory :text_box_template, parent: :box_template do
    content 'content'
  end
end

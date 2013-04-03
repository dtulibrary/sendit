FactoryGirl.define do
  factory :template do |f|
    f.sequence(:code) { |n| "template#{n}" }
    f.body "This is the main body"
    f.association :template_type
    f.association :template_format
    f.association :template_locale
  end
end

FactoryGirl.define do
  factory :template_locale do |f|
    f.sequence(:code) { |n| "code#{n}" }
  end
end

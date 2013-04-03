FactoryGirl.define do
  factory :template_type do |f|
    f.sequence(:code) { |n| "type#{n}" }
  end
end

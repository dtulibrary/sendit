FactoryGirl.define do
  factory :template_format do |f|
    f.sequence(:code) { |n| "code#{n}" }
  end
end

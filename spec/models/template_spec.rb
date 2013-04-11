require 'spec_helper'

describe Template do
  
  it "has a valid factory" do
    FactoryGirl.create(:template).should be_valid
  end

  it "fails without code" do
    FactoryGirl.build(:template, code: nil).should_not be_valid
  end

  it "fails without body" do
    FactoryGirl.build(:template, body: nil).should_not be_valid
  end

  it "fails without template type" do
    FactoryGirl.build(:template, template_type: nil).should_not be_valid
  end

  it "fails without template format" do
    FactoryGirl.build(:template, template_format: nil).should_not be_valid
  end

  it "fails without template locale" do
    FactoryGirl.build(:template, template_locale: nil).should_not be_valid
  end

  it "fails with invalid from date" do
    FactoryGirl.build(:template, valid_from: "bogus").should_not be_valid
  end

  it "fails with invalid to date" do
    FactoryGirl.build(:template, valid_until: "bogus").should_not be_valid
  end

  it "returns untranslated name" do
    template = FactoryGirl.build(:template)
    template.name.should eq "translation missing: en.tsushin.code.template."+template.code
  end

  it "creates template from attributes" do
    template_type = FactoryGirl.create(:template_type)
    template_format = FactoryGirl.create(:template_format)
    template_locale = FactoryGirl.create(:template_locale)
    template = Template.new
    template.update_attributes({
      'code' => 'test.attributes',
      'template_type_id' => template_type.id,
      'template_format_id' => template_format.id,
      'template_locale_id' => template_locale.id,
      'body' => 'Template',
    })
    template.save
  end
end

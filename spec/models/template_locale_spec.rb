require 'spec_helper'

describe TemplateLocale do

  it "has a valid factory" do
    FactoryGirl.create(:template_locale).should be_valid
  end

  it "fails without code" do
    FactoryGirl.build(:template_locale, code: nil).should_not be_valid
  end

  it "returns untranslated name" do
    locale = FactoryGirl.build(:template_locale)
    locale.name.should eq "translation missing: en.tsushin.code.template_locale."+locale.code
  end

   it "fails with duplicate code" do
     locale = FactoryGirl.create(:template_locale)
     FactoryGirl.build(:template_locale, code: locale.code).should_not be_valid
   end

end

require 'spec_helper'

describe TemplateFormat do

  it "has a valid factory" do
    FactoryGirl.create(:template_format).should be_valid
  end

  it "fails without code" do
    FactoryGirl.build(:template_format, code: nil).should_not be_valid
  end

  it "returns untranslated name" do
    format = FactoryGirl.build(:template_format)
    format.name.should eq "translation missing: en.tsushin.code.template_format."+format.code
  end

   it "fails with duplicate code" do
     format = FactoryGirl.create(:template_format)
     FactoryGirl.build(:template_format, code: format.code).should_not be_valid
   end

end

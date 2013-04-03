require 'spec_helper'

describe TemplateType do

  it "has a valid factory" do
    FactoryGirl.create(:template_type).should be_valid
  end

  it "fails without code" do
    FactoryGirl.build(:template_type, code: nil).should_not be_valid
  end

  it "returns untranslated name" do
    type = FactoryGirl.build(:template_type)
    type.name.should eq "translation missing: en.tsushin.code.template_type."+type.code
  end

end

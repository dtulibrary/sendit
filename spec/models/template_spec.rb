require 'spec_helper'

describe Template do

  it "creates template from attributes" do
    template = Template.new
    template.update_attributes({
      'code' => 'test.attributes',
      'html' => 'Template',
    })
    template.save
  end
end

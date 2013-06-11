# -*- coding: utf-8 -*-
require 'spec_helper'

describe SendController do

  before(:each) {
    html =
<<eos
<html><body>
  <p>This <strong>is</string> a test called <emph><%= @test.name %></emph> and it has æøå in it.</p>
  <p>The time is now <%= Time.now.iso8601 %></p>
</body></html>
eos
    plain =
<<eos
  This _is_ a test called /<%= @test.name %>/ and it has æøå in it.
  The time is now <%= Time.now.iso8601 %>
</body></html>
eos

    Template.create(:code        => 'test',
                    :from        => 'someone@example.com',
                    :subject     => '<%= @subject %> with extras in the subject',
                    :html        => html,
                    :plain       => plain,
                    :example     => '{}',
                    :active      => true)

    Template.create(:code        => 'broken',
                    :from        => 'someone@example.com',
                    :subject     => '<%= subject %> with extras in the subject',
                    :html        => html,
                    :plain       => plain,
                    :example     => '{}',
                    :active      => true)

    ActionMailer::Base.deliveries.clear
  }

  let(:data) {
    {
      to: "someone@example.com",
      from: "someone@example.com",
      subject: "This is a test",
      test: {
        name: "hello world"
      }
    }.to_json
  }

  describe "#post" do
    it "should send email for valid template and data" do
      request.env['RAW_POST_DATA'] = data
      post :post, :template_name => 'test', :priority => 'now', :content_type => 'application/json'
      ActionMailer::Base.deliveries.size.should eq(1)
    end

    it "should not send email for unknown template" do
      request.env['RAW_POST_DATA'] = '{}'
      expect {
        post(:post, :template_name => 'unknown',
             :priority => 'now', :content_type => 'application/json')
      }.to raise_error
      ActionMailer::Base.deliveries.size.should eq(0)
    end

    it "should not send email for broken template" do
      request.env['RAW_POST_DATA'] = data
      expect {
        post(:post, :template_name => 'broken',
             :priority => 'now', :content_type => 'application/json')
      }.to raise_error
      ActionMailer::Base.deliveries.size.should eq(0)
    end

    it "should not send email for invalid data" do
      request.env['RAW_POST_DATA'] = '{]'
      expect {
        post(:post, :template_name => 'test',
             :priority => 'now', :content_type => 'application/json')
      }.to raise_error
      ActionMailer::Base.deliveries.size.should eq(0)
    end

  end

end

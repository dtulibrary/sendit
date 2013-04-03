require 'spec_helper'
include Devise::TestHelpers

describe Admin::TemplatesController do
  render_views

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  after(:each) do
    @user.destroy
  end

  describe "GET #index" do
    it "renders the :index view" do
      get :index
      response.status.should be(200)
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "renders the #show view" do
      get :show, id: FactoryGirl.create(:template)
      response.status.should be(200)
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "shows the new template" do
      get :new
      response.status.should be(200)
      response.should render_template :new
    end
  end

  describe "GET #edit" do
    it "shows the edit template" do
      get :edit, id: FactoryGirl.create(:template)
      response.status.should be(200)
      response.should render_template :edit
    end
  end

end

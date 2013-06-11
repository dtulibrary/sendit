class SentEmailsController < ApplicationController
  def index
    @sent_grid = initialize_grid(SentEmail, :include => :template, :per_page => 50)
  end

  def show
    @sent_email = SentEmail.find(params[:id])
  end
end

class TemplatesController < ApplicationController
  def index
    @templates = Template.where(:displayed => true).order("code ASC, created_at DESC")
  end

  def show
    @template = Template.find(params[:id])
  end

  def new
    @template = Template.new
    @template.from    = '<%= @from %>'
    @template.subject = '<%= @subject %>'
    @template.html    = 'Here goes the html template'
    @template.plain   = 'Here goes the plain text template'
    @template.example = '{"to": "to@example.com", "from": "from@example.com", "subject": "Subject"}'
  end

  def edit
    @template = Template.find(params[:id])
  end

  def create
    @template = Template.new(params[:template])
    @template.displayed = true
    if @template.save
      redirect_to @template
    else
      render action: "new"
    end
  end

  def update
    @template = Template.find(params[:id])

    respond_to do |format|
      if @template.update_attributes(params[:template])
        format.html { redirect_to @template, notice: 'Template was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @template = Template.find(params[:id])
    @template.displayed = false
    @template.save

    respond_to do |format|
      format.html { redirect_to templates_url }
      format.json { head :no_content }
    end
  end

  def activate
    template = Template.find(params[:id])

    Template.transaction do
      Template.where("code = ?", template.code).update_all(:active => false)
      template.update_attribute(:active, true)
    end

    redirect_to :templates
  end


  def duplicate
    template = Template.find(params[:id]).dup
    template.active = false
    template.save

    redirect_to :templates
  end

  def try
    begin
      template = Template.new(:html => params[:html], :plain => params[:plain], :subject => params[:subject], :from => params[:from])
      data     = JSON.parse(params[:data])

      respond_to do |format|
        format.json do
          email = template.to_email(data)
          
          rendered = {
            :raw     => email.encoded,
            :from    => template.render_from(data),
            :subject => template.render_subject(data),
            :html    => template.render_html(data),
            :plain   => template.render_plain(data)
          }
          
          if params[:send] == 'true'
            raise "To address cannot be empty" if params[:to].blank?
            email.to = params[:to]
            email.deliver
          end
          
          render :json => rendered            
          
        end
      end
    rescue Exception => e
      render :text => ["<pre>", e.to_s, "", e.backtrace, "</pre>"].flatten.join("\n"), :status => :internal_server_error
    end
  end

end

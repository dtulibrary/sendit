require 'tilt'
require 'mail'
require 'json'

class Rest::SendController < ApplicationController
  def create
    #  We should get the following options
    #    template to use
    #    locale to use (or use default locale for this app)
    #    type of message to send
    #  Then we locate the template that we should send
    #    Based on the template format it is processed by a render
    #    The result will either be sent
    #    Nice: If this is a "test" setup, then a way to test if the data
    #          sent uses new parts of a template, so the data could be saved
    #          as testdata for future tests.
    #  The data sent must be made accessible for the template processing.
    
    # Parse body request into a json structure.
    params = JSON.parse request.body.read

    # For now we only support sending emails.
    # When that change, make the logic different for each type as needed

    email = Mail.new do
      to        params['to']
      from      'test@local.domain'
      subject   params['subject']
    end

    html_template = Template.current_template(params['template'], 'email-html',
      params['locale'])
    output_template = Tilt.new(html_template.template_format.code) do
      html_template.body
    end
    email.html_part = Mail::Part.new do
      content_type 'text/html; charset=UTF-8'
      body output_template.render(params['payload'])
    end

    text_template = Template.current_template(params['template'], 'email-text',
      params['locale'])
    output_template = Tilt.new(text_template.template_format.code) do
      text_template.body
    end
    email.html_part = Mail::Part.new do
      content_type 'text/plain; charset=UTF-8'
      body output_template.render(params['payload'])
    end

    email.deliver

    # The end result is a template with information about what we did
    @result = { method: "e-mail", to: params['to'] }
    # TODO: Assign result to template rendering
    respond_to do |format|
      format.html # { render }
      format.json { render :json => @result }
    end
  end
end

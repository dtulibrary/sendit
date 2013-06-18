class SendController < ApplicationController
  skip_before_filter :authenticate

  def post
    send_email(params[:template_name], request.body.read, params[:priority])
  end

  private

  def send_email(template_name, json_data, priority)
    data = JSON.parse(json_data)
    job = EmailJob.new(template_name, data)

    result = case priority
             when 'now'
               job.perform
               {:sent => true}
             when 'high'
               Delayed::Job.enqueue(job, :priority => 0)
               {:enqueued => true, :priority => 0}
             else
               Delayed::Job.enqueue(job, :priority => 20)
               {:enqueued => true, :priority => 20}
             end

    respond_to do |format|
      format.html { render :text => result.to_s }
      format.json { render :json => result }
    end
  end


  class EmailJob < Struct.new(:template_name, :data)
    def perform
      template = Template.current(template_name)
      email = template.to_email(data)
      Delayed::Worker.logger.info "Content: #{email.encoded}"
      email.deliver
      Delayed::Worker.logger.info "Email sent to #{data['to']} from template #{template_name}"
      template.sent_emails.create(:to_address => data['to'],
                                  :data => JSON.pretty_generate(data),
                                  :message => email.encoded)
    end
  end

end

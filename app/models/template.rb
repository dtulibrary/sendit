class Template < ActiveRecord::Base
  attr_accessible :active, :code, :displayed, :example, :from, :html, :plain, :subject, :reply_to, :cc

  validates :code,    :presence => true
  validates :example, :presence => true
  validates :from,    :presence => true
  validates :subject, :presence => true

  has_many :sent_emails

  def self.current(name)
    Template.where(:code => name, :active => true, :displayed => true).first or raise ActiveRecord::RecordNotFound
  end

  def current?
    self.active
  end

  class Context
    include ActionView::Helpers::TextHelper

    def initialize(hash)
      mash = Hashie::Mash.new(hash)
      mash.each_pair do |key, value|
        instance_variable_set('@' + key.to_s, value)
      end
    end

    def get_binding
      binding
    end
  end

  def self.render_erb(erb, hash)
    context = Context.new(hash).get_binding()
    ERB.new(erb.gsub("\r\n", "\n"), nil, '-').result(context)
  end

  def render_from(hash)
    Template.render_erb(self.from, hash)
  end

  def render_subject(hash)
    Template.render_erb(self.subject, hash)
  end

  def render_html(hash)
    Template.render_erb(self.html, hash)
  end

  def render_plain(hash)
    Template.render_erb(self.plain, hash)
  end


  class TemplateMailer < ActionMailer::Base
    def email(template, data)
      mail_params = {
        :from                      => template.render_from(data),
        :to                        => data["to"],
        :subject                   => template.render_subject(data),
        'X-Auto-Response-Suppress' => 'OOF',
        'Auto-Submitted'           => 'auto-generated'
      }

      mail_params[:reply_to] = data["reply_to"] if data["reply_to"]
      mail_params[:cc]       = data["cc"] if data["cc"]
      mail_params[:charset]  = data["charset"] if data["charset"]

      mail(mail_params) do |format|
        text_plain = template.render_plain(data)
        text_html  = template.render_html(data)
        format.text { render :text => text_plain } unless text_plain.blank?
        format.html { render :text => text_html } unless text_html.blank?
      end
    end
  end

  def to_email(hash)
    TemplateMailer.email(self, hash)
  end

end

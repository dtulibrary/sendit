class Template < ActiveRecord::Base
  attr_accessible :active, :code, :displayed, :example, :from, :html, :plain, :subject

  validates :code,    :presence => true
  validates :html,    :presence => true
  validates :plain,   :presence => true
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
      mail(:from                      => template.render_from(data),
           :to                        => data["to"],
           :subject                   => template.render_subject(data),
           'X-Auto-Response-Suppress' => 'OOF',
           'Auto-Submitted'           => 'auto-generated',
      ) do |format|
        format.text { render :text => template.render_plain(data) }
        format.html { render :text => template.render_html(data) }
      end
    end
  end

  def to_email(hash)
    TemplateMailer.email(self, hash)
  end

end

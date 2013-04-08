class TemplateLocale < ActiveRecord::Base
  attr_accessible :code

  validates :code, :presence => true, :uniqueness => true

  def name
    I18n.t code, :scope => 'tsushin.code.template_locale'
  end

end

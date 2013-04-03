class Template < ActiveRecord::Base
  belongs_to :template_type
  belongs_to :template_format
  belongs_to :template_locale
  just_define_datetime_picker :valid_from, :add_to_attr_accessible => true
  just_define_datetime_picker :valid_until, :add_to_attr_accessible => true
  attr_accessible :body, :code

  validates :code, :presence => true
  validates :body, :presence => true
  validates :template_type, :presence => true
  validates :template_format, :presence => true
  validates :template_locale, :presence => true
  validates_datetime :valid_from, :allow_nil => true
  validates_datetime :valid_until, :allow_nil => true

  # TODO: Validate valid_from <= valid_until
  # TODO: Validate code unique in given timerange

  def name
    I18n.t code, :scope => 'tsushin.code.template'
  end

end

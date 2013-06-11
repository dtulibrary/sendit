class SentEmail < ActiveRecord::Base
  belongs_to :template
  attr_accessible :data, :message, :to_address
end

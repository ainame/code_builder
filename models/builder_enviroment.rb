require_relative 'active_record/act_as_random_id'

class BuilderEnviroment < ActiveRecord::Base
  include ActiveRecord::ActAsRandomId

  attr_accessible :params_json, :package_id
  validates_presence_of :params_json, :package_id
  belongs_to :package

  scope :latest, order('created_at desc')
end

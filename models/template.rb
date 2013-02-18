require_relative 'active_record/act_as_random_id'

class Template < ActiveRecord::Base
  include ActiveRecord::ActAsRandomId

  has_one  :affiliations, :dependent => :destroy
  has_many :packages, :through => :affiliations
  has_many :categories, :through => :packages

  attr_accessible :name, :body
  validates_presence_of :name, :body
  before_create :remove_carriage_return

  scope :latest, order('created_at desc')

  private
  def remove_carriage_return
    self.body = self.body.gsub(/\r/,'')
  end
end

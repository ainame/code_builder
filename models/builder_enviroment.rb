class BuilderEnviroment < ActiveRecord::Base
  attr_accessible :params_json, :template_id, :name, :description
  validates_presence_of :params_json, :template_id
  before_create :set_access_token
  belongs_to :template

  scope :latest, order('created_at desc')

  private
  def set_access_token
    self.access_token = self.access_token.blank? ? generate_access_token : self.access_token
  end

  def generate_access_token
    tmp_token = SecureRandom.urlsafe_base64(6)
    self.class.where(:access_token => tmp_token).blank? ? tmp_token : generate_access_token
  end
end

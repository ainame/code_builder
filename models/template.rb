class Template < ActiveRecord::Base
  belongs_to :affiliations

  attr_accessible :name, :body
  validates_presence_of :name, :body
  before_create :set_access_token, :remove_carriage_return
  has_one :builder_enviroment
  scope :latest, order('created_at desc')

  private
  def set_access_token
    self.access_token = self.access_token.blank? ? generate_access_token : self.access_token
  end

  def generate_access_token
    tmp_token = SecureRandom.urlsafe_base64(6)
    self.class.where(:access_token => tmp_token).blank? ? tmp_token : generate_access_token
  end

  def remove_carriage_return
    self.body = self.body.gsub(/\r/,'')
  end

end

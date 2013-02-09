module ActiveRecord
  module ActAsRandomId
    def self.included base
      base.class_eval do
        before_create :set_access_token        
      end
    end

    def set_access_token
      self.access_token = self.access_token.blank? ? generate_access_token : self.access_token
    end

    def generate_access_token
      tmp_token = SecureRandom.urlsafe_base64(6)
      self.class.where(:access_token => tmp_token).blank? ? tmp_token : generate_access_token
    end
  end
end

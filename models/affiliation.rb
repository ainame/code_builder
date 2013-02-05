class Affiliation < ActiveRecord::Base
  attr_accessible :template_id, :package_id

  has_one :template
  has_one :package
end

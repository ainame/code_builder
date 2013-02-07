class Affiliation < ActiveRecord::Base
  attr_accessible :template_id, :package_id

  belongs_to :template
  belongs_to :package
end

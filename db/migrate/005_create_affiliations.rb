class CreateAffiliations < ActiveRecord::Migration
  def self.up
    create_table :affiliations do |t|
      t.integer :package_id, :null => false
      t.integer :template_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :affiliations
  end
end

class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.string :access_token, :null => false, :limit => 6
      t.string :name, :null => false
      t.text :body, :null => false
      t.timestamps
    end
    add_index :templates, :access_token, :unique => true
  end

  def self.down
    drop_table :templates
  end
end

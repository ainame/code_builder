class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.string :name, :null => false
      t.string :access_token, :null => false
      t.integer :category_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :packages
  end
end

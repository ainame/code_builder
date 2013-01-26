class AddColumn < ActiveRecord::Migration
  def self.up
    add_column :builder_enviroments, :name, :string
    add_column :builder_enviroments, :description, :text
    add_column :templates, :description, :text
  end

  def self.down
    remove_column :builder_enviroments, :name
    remove_column :builder_enviroments, :description
    remove_column :templates, :description
  end
end

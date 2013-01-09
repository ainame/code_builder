class CreateEnviroments < ActiveRecord::Migration
  def change
    create_table :builder_enviroments do |t|
      t.string :access_token, :null => false, :limit => 6
      t.integer :template_id
      t.text :params_json
      t.timestamps
    end
    add_index :builder_enviroments, :access_token, :unique => true
  end
end

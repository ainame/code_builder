class ChangeColumnTemplateIdToPackageId < ActiveRecord::Migration
  def self.up
    rename_column :builder_enviroments, :template_id, :package_id
  end

  def self.down
    rename_column :builder_enviroments, :package_id, :template_id
  end
end

require_relative 'category/consequence_command'

class Category
  include ActiveModel::Conversion
  attr_reader :id, :name
  TYPES = {
    '1' => 'Code',
    '2' => 'Hive',
    '3' => 'Mailto',
    '4' => 'Jira',
  }.freeze

  INSTANCES = {}

  def self.get_instance(category_id)
    INSTANCES[category_id.to_s]
  end

  def self.all
    INSTANCES.values
  end

  def persisted?
    false
  end

  def command_format
    Category::ConsequenceCommand.get_format(@name)
  end

  private
  def self.create_instance(category_id)
    category = Category.new
    category.instance_eval do
      if TYPES.keys.include?(category_id.to_s)
        @id   = category_id.to_s
        @name = TYPES[category_id.to_s]
      else
        raise
      end
    end

    category
  end  

  INSTANCES = TYPES.map do |key, name|
    { key => self.create_instance(key) }
  end.inject({}){|hash, elem| hash.merge(elem)}.freeze

end

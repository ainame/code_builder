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

  def initialize(category_id)
    if TYPES.keys.include?(category_id.to_s)
      @id   = category_id.to_s
      @name = TYPES[category_id.to_s]
    else
      raise
    end
  end

  def self.all
    @instances ||= TYPES.map do |k,v| ::Category.new(k) end   
  end

  def persisted?
    false
  end

  def command_format
    Category::ConsequenceCommand.get_format(@name)
  end
end

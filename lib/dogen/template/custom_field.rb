class Dogen
  class Template
    class CustomField
      attr_reader :name, :init_value
      attr_accessor :value

      def initialize(name, &block)
        raise "NoInitializedValueError" unless block_given?

        @name = name.to_s
        @init_value = block.call
        @value = @init_value.dup
      end
    end
  end
end

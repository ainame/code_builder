require_relative 'custom_field'

class Dogen
  class Template
    module CustomFieldExtractor
      class SandBoxEvaluator
        attr_reader :custom_fields
        SAFE_LEVEL = 4

        def initialize
          @custom_fields = []
          @custom_field_pusher = Proc.new do |custom_field|
            # This block context has safe-level 1.
            @custom_fields.push(custom_field)
          end
        end

        def in_safe
          result = nil
          Thread.start do
            $SAFE = SAFE_LEVEL
            result = yield self
          end.join
          result
        end

        # I/F for template header
        def custom_field(name, &block)
          custom_field = Dogen::Template::CustomField.new(name, &block)
          @custom_field_pusher.call(custom_field)
        end
      end

      def self.perform(raw_body)
        custom_fields_block = self.parse_raw_body(raw_body)
        return [] if custom_fields_block.empty?

        sand_box = SandBoxEvaluator.new
        sand_box.in_safe do |this|
          this.instance_eval { eval custom_fields_block }
         end
        sand_box.custom_fields
      end

      REGEXP_DEFINE_HEADER = /\A<%$\n(?<declaration_header>.*?)^%>$/m
      def self.parse_raw_body(raw_body)
        return '' unless raw_body =~ REGEXP_DEFINE_HEADER
        declaration_header = Regexp.last_match[:declaration_header]
        declaration_header.each_line.map(&:strip).join("\n")
      end
    end
  end
end

require 'json'
require 'active_support/all'
class Dogen
  class Enviroment
    module Plugins
      module Hiveql
        def self.included(base)
          base.register_variable('json_dataset', '')
          base.register_variable('_dataset', nil)
        end

        module HelperMethods
          def date_loop start_date_str, end_date_str, &block
            start_date_obj = Date.parse(start_date_str)
            end_date_obj   = Date.parse(end_date_str)
            _iterate_date(start_date_obj, end_date_obj, &block)
          end

          def _iterate_date &block
            diff = end_date_obj - start_date_obj            
            diff.times do |delta|
              current_date = (start_date_obj + delta).to_s
              yield current_date
            end
          end

          def match_path path
            'parse_url(concat("http://aa.jp", url),"PATH") = #{path}'
          end

          def match_query key, value
            'parse_url(concat("http://aa.jp", url),"QUERY", #{key}) = #{value}'
          end

          def and_where_valid_access
            <<~EOS
            and status regexp '^2'
            and member_id <> '-'
            EOS
          end

          def dataset            
            _dataset ||= JSON.parse(json_dataset)
          end
        end
      end
    end
  end
end

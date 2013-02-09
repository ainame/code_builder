# -*- coding: utf-8 -*-
require 'active_support/core_ext/string/inflections'

class Category
  module ConsequenceCommand
    def self.get_format(category_name)
      begin
        class_name = "::Category::ConsequenceCommand::" + category_name.classify
        class_name.constantize.format
      rescue => e
        warn e.message
      end
    end

    module Code
      def self.format
        "$ curl %s | ruby"
      end
    end

    module Hive
      def self.format
        "$ hive -e \"$(curl %s)\""
      end    
    end

    module Mailto
      def self.format
        "<a href=\"mailto:%s?%s\">execute mailer</a>"
      end
    end

    module Jira
      def self.execute
        "<a href=\"%s\">Open Jira page</a>"
      end
    end
  end
end

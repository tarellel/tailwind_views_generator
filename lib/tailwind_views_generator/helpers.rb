# frozen_string_literal: true

module TailwindViewsGenerator
  module Helpers
    # Return a cleaned up version of the name of the application being generated
    # @return [String]
    def app_name
      @app_name ||= if Rails.version.to_f >= 6.0
                      Rails.app_class.module_parent_name.demodulize.titleize
                    else
                      Rails.application.class.parent.to_s.titleize
                    end
    end
  end
end
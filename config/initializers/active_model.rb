require 'email_validator'

require 'action_view/helpers/active_model_helper'

module ActionView
  module Helpers
    module ActiveModelInstanceTag
      # Hacked to allow customizing the errors considered to exist under a field.
      def error_message
        if object.respond_to?(:errors_under)
          object.errors_under(@method_name)
        else
          object.errors[@method_name]
        end
      end
    end
  end
end

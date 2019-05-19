# See: http://marianposaceanu.com/articles/improve-rails-performance-by-adding-a-few-gems
# See: https://github.com/brianmario/escape_utils
begin
  
  # For more performant HTML escaping.
  require 'escape_utils/html/rack' # to patch Rack::Utils
  require 'escape_utils/html/erb' # to patch ERB::Util
  require 'escape_utils/html/cgi' # to patch CGI
  
  # For more performant URL and URI escaping.
  require 'escape_utils/url/cgi' # to patch CGI
  require 'escape_utils/url/erb' # to patch ERB::Util
  #require 'escape_utils/url/rack' # to patch Rack::Utils  (causes incorrect form parameter parsing)
  require 'escape_utils/url/uri' # to patch URI
  
  # For more performant JavaScript escaping.
  require 'escape_utils/javascript/action_view' # to patch ActionView::Helpers::JavaScriptHelper
  
  # Disable escaping of "/" in HTML.
  EscapeUtils.html_secure = false
rescue LoadError
  Rails.logger.info 'Escape_utils is not in the gemfile'
end
# Monkey patches for Rails 3.2.x compatibility with Ruby 2.7+
# This file must be loaded AFTER Rails is loaded (i.e., after require 'rails/all')

if defined?(ActiveSupport::VERSION) && ActiveSupport::VERSION::STRING =~ /^3\.2\./
  # Fix: Frozen string literal errors in ActionDispatch::Routing::RouteSet#url_for
  # Ruby 2.7+ freezes string literals, Rails 3.2's url_for does `path << path_addition`
  # where path can be a frozen empty string from .to_s
  require 'action_dispatch/routing/route_set'

  ActionDispatch::Routing::RouteSet.class_eval do
    def url_for(options, &block)
      finalize!
      options = (options || {}).reverse_merge!(default_url_options)

      handle_positional_args(options)

      user, password = extract_authentication(options)
      path_segments  = options.delete(:_path_segments)
      script_name    = options.delete(:script_name)

      # Fix: Ensure path is mutable by using dup instead of just .to_s
      path = (script_name.blank? ? _generate_prefix(options) : script_name.chomp('/')).to_s.dup

      path_options = options.except(*ActionDispatch::Routing::RouteSet::RESERVED_OPTIONS)
      path_options = yield(path_options) if block_given?

      path_addition, params = generate(path_options, path_segments || {})
      path << path_addition
      params.merge!(options[:params] || {})

      ActionDispatch::Http::URL.url_for(options.merge!({
        :path => path,
        :params => params,
        :user => user,
        :password => password
      }))
    end
  end
end

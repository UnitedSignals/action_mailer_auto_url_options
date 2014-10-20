require 'action_dispatch/http/url'

module ActionDispatch
  module Http
    module URL
      class << self
        alias_method :am_original_url_for, :url_for

        def url_for(opts = {})
          options = opts.dup

          if !options.has_key?(:host) && Thread.current[:actionmailer_request_host]
            options[:host] = Thread.current[:actionmailer_request_host]
          end

          if !options.has_key?(:protocol) && Thread.current[:actionmailer_request_protocol]
            options[:protocol] = Thread.current[:actionmailer_request_protocol]
          end

          am_original_url_for(options)
        end
      end
    end
  end
end

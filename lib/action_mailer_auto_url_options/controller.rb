module ActionMailerAutoUrlOptions

  # Included in the app's Application Controller
  module Controller
    extend ActiveSupport::Concern

    included do
      before_filter :make_action_mailer_use_request_host_and_protocol
      after_filter :clear_action_mailer_thread_local
    end

    private

    def make_action_mailer_use_request_host_and_protocol
      Thread.current[:actionmailer_request_host]     = request.host_with_port
      Thread.current[:actionmailer_request_protocol] = request.protocol
    end

    def clear_action_mailer_thread_local
      Thread.current[:actionmailer_request_host]     = nil
      Thread.current[:actionmailer_request_protocol] = nil
    end
  end

end

require 'json'

module Slack
  class Event
    def initialize(event)
      @event = event
    end

    def validate
      body = @event['body']

      msg = nil
      if body['token'] != env['SLACK_VERIFICATION_TOKEN']
        msg = "Invalid token"
      elsif body['api_app_id'] != env['SLACK_APP_ID']
        msg = "Invalid api_app_id"
      end
      
      unless msg.nil?
        {
          message: msg
        }
      end
    end

    def verify
      body = @event['body']
      if body['type'] =='url_verification'
        {
          challenge: event['body']['challenge']
        }
      end
    end
  end
end
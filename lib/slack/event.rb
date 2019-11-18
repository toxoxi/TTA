module Slack
  class Event
    def initialize(event)
      @event = event
    end

    def validate
      body = @event['body'] || {}

      msg = nil
      if body['token'] != Slack::Config.slack_verification_token
        msg = "Invalid token"
      elsif body['api_app_id'] != Slack::Config.slack_app_id
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
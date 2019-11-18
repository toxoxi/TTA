module Slack
  module Config
    extend self

    ATTRIBUTES = %i[
      slack_signing_secret
      slack_verification_token
      slack_app_id
      slack_bot_token
    ].freeze

    attr_accessor(*Config::ATTRIBUTES)
    
    def reset
      self.slack_signing_secret = ENV['SLACK_SIGNING_SECRET']
      self.slack_verification_token = ENV['SLACK_VERIFICATION_TOKEN']
      self.slack_app_id = ENV['SLACK_APP_ID']
      self.slack_bot_token = ENV['SLACK_BOT_TOKEN']
    end

    class << self
      def configure
        block_given? ? yield(Config) : Config
      end

      def config
        Config
      end
    end
  end
end

Slack::Config.reset

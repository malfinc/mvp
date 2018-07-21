class RealtimeMessage < ApplicationMessage
  SUBSCRIBE_KEY = "".freeze
  PUBLISH_KEY = "".freeze

  class Pubnub
    def publish(**); end
  end

  private def client
    # @client ||= Pubnub.new(
    #   subscribe_key: SUBSCRIBE_KEY,
    #   publish_key: PUBLISH_KEY
    # )
    Pubnub.new
  end

  private def channel
    if to.present?
      "#{to.to_gid}/#{self.class.const_get(:CHANNEL)}"
    else
      self.class.const_get(:CHANNEL)
    end
  end
end

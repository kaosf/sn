# :nocov:
class SnsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "SnsChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
# :nocov:

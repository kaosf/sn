class SnSubscription < ApplicationRecord
  validates :endpoint, presence: true
  validates :p256dh, presence: true
  validates :auth, presence: true, uniqueness: { scope: %i[p256dh endpoint] }

  def notify(title:, body:, url:)
    return if Rails.env.test?

    # :nocov:
    WebPush.payload_send(
      message: { title:, body:, url: }.to_json,
      endpoint:,
      p256dh:,
      auth:,
      vapid: {
        subject: "", # Email address can be empty.
        public_key: VapidKeys.public_key,
        private_key: VapidKeys.private_key
      }
    )
    # :nocov:
  end
end

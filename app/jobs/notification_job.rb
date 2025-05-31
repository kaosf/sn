class NotificationJob < ApplicationJob
  def perform(sn_id)
    sn = Sn.find(sn_id)
    title = sn.title
    body = "#{url_prefix}/sns/#{sn.uuid}"
    url = "#{url_prefix}/sns/#{sn.uuid}"
    SnSubscription.all.each { it.notify(title:, body:, url:) }
  end

  private

  def url_prefix
    case Rails.env
    when "production"
      # :nocov:
      "https://#{ENV.fetch("DOMAIN", "example.com")}"
      # :nocov:
    when "test"
      "http://localhost:3000"
    when "development"
      # :nocov:
      "http://localhost:#{ENV.fetch("PORT", "3000")}"
      # :nocov:
    else
      # :nocov:
      raise StandardError
      # :nocov:
    end
  end
end

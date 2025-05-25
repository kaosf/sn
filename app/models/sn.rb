class Sn < ApplicationRecord
  after_initialize do
    next if persisted?

    self.uuid = SecureRandom.uuid
  end

  before_create do
    self.t_us = self.created_at.then { it.to_i * 1_000_000 + it.usec }
  end

  after_create_commit do
    body = "#{url_prefix}/sns/#{uuid}"
    url = "#{url_prefix}/sns/#{uuid}"
    SnSubscription.all.each { it.notify(title:, body:, url:) }
    ActionCable.server.broadcast "SnsChannel", { action: "SnCreate" }
  end

  scope :unread, -> { where(read: 0) }
  scope :ordered_by_time_desc, -> { order([ { t_us: :desc }, { id: :desc } ]) }

  validates :title, presence: true
  validates :body, presence: true

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

  def new_and_old_and_unread_models
    new = Sn.ordered_by_time_desc.where("t_us > :t_us OR (t_us = :t_us AND id > :id)", t_us:, id:).last
    old = Sn.ordered_by_time_desc.where("t_us < :t_us OR (t_us = :t_us AND id < :id)", t_us:, id:).first
    new_unread = Sn.unread.ordered_by_time_desc.where("t_us > :t_us OR (t_us = :t_us AND id > :id)", t_us:, id:).last
    old_unread = Sn.unread.ordered_by_time_desc.where("t_us < :t_us OR (t_us = :t_us AND id < :id)", t_us:, id:).first
    [ new, old, new_unread, old_unread ]
  end

  class << self
    def export_jsonl
      order(:id)
      .select(:id, :uuid, :t_us, :read, :created_at, :updated_at, :title, :body)
      .map {
        {
          id: it.id, uuid: it.uuid, t_us: it.t_us, read: it.read,
          created_at: it.created_at.then { "#{it.in_time_zone('UTC').strftime('%Y-%m-%d %H:%M:%S')}.#{format('%06d', it.usec)}" },
          updated_at: it.updated_at.then { "#{it.in_time_zone('UTC').strftime('%Y-%m-%d %H:%M:%S')}.#{format('%06d', it.usec)}" },
          title: it.title, body: it.body
        }.to_json + "\n"
      }.join
    end
  end
end

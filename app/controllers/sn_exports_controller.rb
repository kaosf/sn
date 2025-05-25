class SnExportsController < ApplicationController
  def index
    data = Sn.export_jsonl
    checksum = Digest::SHA256.hexdigest(data)
    timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
    send_data data, filename: "#{timestamp}-#{checksum}-sns.jsonl"
  end
end

class VapidKeys
  class << self
    def public_key
      @public_key ||= keys[:public_key]
    end

    def private_key
      @private_key ||= keys[:private_key]
    end

    private

    def keys
      @keys ||=
        case Rails.env
        when "production"
          {
            public_key: ENV.fetch("VAPID_PUBLIC_KEY"),
            private_key: ENV.fetch("VAPID_PRIVATE_KEY")
          }
        when "development", "test"
          if ENV["VAPID_KEY_USE"] == "1"
            {
              public_key: ENV.fetch("VAPID_PUBLIC_KEY"),
              private_key: ENV.fetch("VAPID_PRIVATE_KEY")
            }
          else
            vapid_public_key = nil
            vapid_private_key = nil
            if File.exist?(Rails.root.join("tmp", "dev-test-vapid-keys.txt"))
              File.open(Rails.root.join("tmp", "dev-test-vapid-keys.txt")) do
                vapid_public_key = it.readline.chomp
                vapid_private_key = it.readline.chomp
              end
            else
              vapid_key = WebPush.generate_key
              File.open(Rails.root.join("tmp", "dev-test-vapid-keys.txt"), "w") do
                it.puts vapid_key.public_key
                it.puts vapid_key.private_key
              end
              vapid_public_key = vapid_key.public_key
              vapid_private_key = vapid_key.private_key
            end
            {
              public_key: vapid_public_key,
              private_key: vapid_private_key
            }
          end
        else
          raise StandardError
        end
    end
  end
end

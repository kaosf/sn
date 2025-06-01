class ApiToken
  class << self
    def correct_token
      case Rails.env
      when "production"
        # :nocov:
        ENV.fetch("API_AUTH_TOKEN", "").tap do
          if it.blank?
            Rails.logger.error "API_AUTH_TOKEN is blank."
            raise StandardError, "API_AUTH_TOKEN is blank."
          end
          if it.size < 30
            Rails.logger.error "API_AUTH_TOKEN is short. it.size: #{it.size} < 30"
            raise StandardError, "API_AUTH_TOKEN is short. it.size: #{it.size} < 30"
          end
        end
        # :nocov:
      when "test"
        "api-auth-token"
      when "development"
        # :nocov:
        "api-auth-token"
        # :nocov:
      else
        # :nocov:
        raise StandardError, "Invalid environment: #{Rails.env}"
        # :nocov:
      end
    end
  end
end

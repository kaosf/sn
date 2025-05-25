# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if Rails.env.development?
  User.create email_address: "1@example.com", password: "password" if User.count < 1
end

if Rails.env.production?
  if User.count < 1
    User.create email_address: ENV["EMAIL_ADDRESS_1"], password_digest: ENV["PASSWORD_DIGEST_1"]
  end
  if User.count < 2 && ENV["EMAIL_ADDRESS_2"].present? && ENV["PASSWORD_DIGEST_2"].present?
    User.create email_address: ENV["EMAIL_ADDRESS_2"], password_digest: ENV["PASSWORD_DIGEST_2"]
  end
  if User.count < 3 && ENV["EMAIL_ADDRESS_3"].present? && ENV["PASSWORD_DIGEST_3"].present?
    User.create email_address: ENV["EMAIL_ADDRESS_3"], password_digest: ENV["PASSWORD_DIGEST_3"]
  end
end

# NOTE: BCrypt::Password.create("my-real-password-...") #=> "$2a$12$..."

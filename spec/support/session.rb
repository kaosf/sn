def sign_in
  user = FactoryBot.create :user
  @__support_session_current_user = user
  post '/session', params: { email_address: user.email_address, password: 'password' }
end

def current_user
  @__support_session_current_user
end

def sign_out
  delete '/session'
  @__support_session_current_user = nil
end

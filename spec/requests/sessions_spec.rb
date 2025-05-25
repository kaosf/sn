require 'rails_helper'

RSpec.describe '/sessions', type: :request do
  before { @user = create :user }

  describe 'POST /sessions' do
    let(:email_address) { @user.email_address }
    let(:password) { 'password' }

    subject { post '/session', params: { email_address:, password: } }

    it { subject; expect(response).to redirect_to(root_url) }

    context 'invalid email_address' do
      let(:email_address) { 'invalid@example.com' }

      it { subject; expect(response).to redirect_to(new_session_url) }
    end

    context 'invalid password' do
      let(:password) { 'invalid-password' }

      it { subject; expect(response).to redirect_to(new_session_url) }
    end
  end
end

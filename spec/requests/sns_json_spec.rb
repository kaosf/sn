require 'rails_helper'

RSpec.describe '/sns', type: :request do
  describe 'POST /sns' do
    let(:token) { "api-auth-token" }
    let(:params) { { title: 'Title', body: 'Body' } }

    subject { post sns_url, headers: { authorization: "Bearer #{token}" }, params: }

    it { expect { subject }.to(change { Sn.count }.by(1)) }

    context do
      let(:token) { 'invalid-token' }

      it { subject; expect(response.status).to eq 401 }
    end

    context do
      before { allow(ApiToken).to receive(:correct_token).and_raise(StandardError) }

      it { subject; expect(response.status).to eq 500 }
    end

    context do
      let(:params) { { title: '', body: '' } }

      it { subject; expect(response.status).to eq 422 }
    end
  end
end

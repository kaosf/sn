require 'rails_helper'

RSpec.describe '/sn_subscriptions', type: :request do
  before { sign_in }

  describe 'GET /sn_subscriptions' do
    it do
      get sn_subscriptions_path
      expect(response).to be_successful
    end
  end

  describe 'GET /sn_subscriptions/1' do
    it do
      get sn_subscription_path(create(:sn_subscription))
      expect(response).to be_successful
    end
  end

  describe 'GET /sn_subscriptions/new' do
    it do
      get new_sn_subscription_path
      expect(response).to be_successful
    end
  end

  describe 'POST /sn_subscriptions' do
    let(:params) { { sn_subscription: { endpoint: 'e', p256dh: 'p', auth: 'a' } } }
    subject { post sn_subscriptions_path, params: }

    it { expect { subject }.to(change { SnSubscription.count }.by(1)) }

    context do
      let(:params) { { sn_subscription: { endpoint: '', p256dh: '', auth: '' } } }

      it { subject; expect(response).to be_unprocessable }
    end
  end

  describe 'POST /sn_subscriptions' do
    it do
      sn_subscription = create(:sn_subscription)
      expect { delete sn_subscription_path(sn_subscription) }.to change { SnSubscription.count }.by(-1)
    end
  end
end

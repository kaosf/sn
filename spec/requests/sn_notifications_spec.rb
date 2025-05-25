require 'rails_helper'

RSpec.describe '/sn_notifications', type: :request do
  before { sign_in }

  describe 'POST /sn_notifications' do
    let(:sn_subscription_id) { create(:sn_subscription).id }

    subject { post sn_notifications_path, params: { sn_subscription_id: } }

    it do
      expect_any_instance_of(SnSubscription).to receive(:notify)
      subject
    end

    it do
      subject
      expect(response).to redirect_to(sn_subscriptions_url)
    end
  end
end

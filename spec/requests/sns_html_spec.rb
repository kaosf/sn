require 'rails_helper'

RSpec.describe '/sns', type: :request do
  before { sign_in }

  describe 'GET /sns' do
    before { create :sn }

    subject { get sns_url format: 'html' }

    it { subject; expect(response).to be_successful }

    context do
      before { sign_out }

      it { subject; expect(response).to be_redirect }
    end
  end

  describe 'GET /sns?unread=1' do
    before { create :sn }

    subject { get sns_url format: 'html', params: { unread: "1" } }

    it { subject; expect(response).to be_successful }

    context do
      before { sign_out }

      it { subject; expect(response).to be_redirect }
    end
  end

  describe 'GET /sns/:id' do
    subject { get sn_url FactoryBot.create(:sn).uuid, format: 'html' }

    it { subject; expect(response).to be_successful }

    context do
      before { sign_out }

      it { subject; expect(response).to be_redirect }
    end
  end
end

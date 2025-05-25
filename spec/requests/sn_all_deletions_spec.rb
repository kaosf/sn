require 'rails_helper'

RSpec.describe '/sn_all_deletions', type: :request do
  before { sign_in }

  describe 'POST /sn_all_deletions' do
    before { create :sn }

    it { expect(Sn.count).to be > 0 }

    it do
      post sn_all_deletions_path
      expect(Sn.count).to eq 0
    end
  end
end

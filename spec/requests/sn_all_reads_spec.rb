require 'rails_helper'

RSpec.describe '/sn_all_reads', type: :request do
  before { sign_in }

  describe 'POST /sn_all_reads' do
    it do
      sn = create :sn, read: 0
      post sn_all_reads_path
      expect(sn.reload.read).to eq 1
    end
  end
end

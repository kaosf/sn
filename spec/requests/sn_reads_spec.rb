require 'rails_helper'

RSpec.describe '/sn_reads', type: :request do
  before { sign_in }

  describe 'PUT /sn_reads/:id' do
    it do
      sn = create :sn, read: 0
      put sn_read_path(id: sn.uuid)
      expect(sn.reload.read).to eq 1
    end
  end
end

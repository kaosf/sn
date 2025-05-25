require 'rails_helper'

RSpec.describe '/sn_exports', type: :request do
  before { sign_in }

  describe 'GET /sn_exports' do
    it do
      get sn_exports_path
      expect(response).to be_successful
    end
  end
end

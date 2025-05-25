require 'rails_helper'

RSpec.describe '/home', type: :request do
  before { sign_in }

  describe 'GET /menu' do
    subject { get menu_url }

    it { subject; expect(response).to be_successful }
  end
end

require 'rails_helper'

RSpec.describe '/sn_imports', type: :request do
  before { sign_in }

  describe 'POST /sn_imports' do
    let(:file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'sns.jsonl')) }

    subject { post sn_imports_path, params: { file: } }

    context 'sn exists' do
      before { create :sn }

      it { subject; expect(response).to be_unprocessable }
    end

    context 'no file' do
      let(:file) { nil }

      it { subject; expect(response).to be_unprocessable }
    end

    it { subject; expect(response).to redirect_to(new_sn_import_url) }
    it { expect { subject }.to change { Sn.count }.from(0).to(10) }
  end
end

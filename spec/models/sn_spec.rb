require 'rails_helper'

RSpec.describe Sn, type: :model do
  describe "after_create_commit" do
    it do
      expect(NotificationJob).to have_been_enqueued.with(Integer)
      create :sn
    end

    it do
      server = instance_double('server')
      allow(ActionCable).to receive(:server).and_return(server)
      expect(server).to receive(:broadcast).with("SnsChannel", { action: "SnCreate" })
      create :sn
    end
  end

  describe "#new_and_old_and_unread_models" do
    before do
      # `travel_to` discards millisecond, so test with second level.
      travel_to(Time.at(Time.now.to_i)) do
        @sn = create :sn, read: 1
      end
    end

    describe "assertions" do
      describe("Sn.count") { it { expect(Sn.count).to eq 1 } }
      describe("t_us ms us") { it { expect(@sn.t_us % 1_000_000).to eq 0 } }
    end

    subject { @sn.new_and_old_and_unread_models }

    it { is_expected.to eq [ nil, nil, nil, nil ] }

    context "new" do
      before do
        travel_to(@sn.created_at + 1.second) do
          @sn_new = create :sn, read: 1
        end
        travel_to(@sn.created_at + 2.second) do
          create :sn, read: 1
        end
      end

      it { expect(Sn.count).to eq 3 }
      it { is_expected.to eq [ @sn_new, nil, nil, nil ] }
    end

    context "new but same t_us and upper id" do
      before do
        travel_to(@sn.created_at) do
          @sn_new = create :sn, read: 1
        end
      end

      it { expect(@sn_new.id).to be > @sn.id }
      it { expect(@sn_new.t_us).to eq @sn.t_us }
      it { is_expected.to eq [ @sn_new, nil, nil, nil ] }
    end

    context "old" do
      before do
        travel_to(@sn.created_at - 1.second) do
          @sn_old = create :sn, read: 1
        end
        travel_to(@sn.created_at - 2.second) do
          create :sn, read: 1
        end
      end

      it { expect(Sn.count).to eq 3 }
      it { is_expected.to eq [ nil, @sn_old, nil, nil ] }
    end

    context "old but same t_us and lower id" do
      before do
        travel_to(@sn.created_at) do
          @sn_old = create :sn, read: 1
        end
        # @sn_old.id > @sn.id, so flip them.
        @sn, @sn_old = @sn_old, @sn
      end

      it { expect(@sn_old.id).to be < @sn.id }
      it { expect(@sn_old.t_us).to eq @sn.t_us }
      it { is_expected.to eq [ nil, @sn_old, nil, nil ] }
    end
  end

  describe 'Sn.export_jsonl' do
    subject { described_class.export_jsonl }

    before { create_list :sn, 2 }

    it { is_expected.to be_kind_of String }
    it { expect { subject }.not_to raise_error }
  end
end

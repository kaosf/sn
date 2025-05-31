require 'rails_helper'

RSpec.describe NotificationJob, type: :job do
  before do
    create :sn_subscription
    @sn = create :sn
  end

  subject { described_class.new.perform(@sn.id) }

  it do
    expect_any_instance_of(SnSubscription).to receive(:notify)
    subject
  end
end

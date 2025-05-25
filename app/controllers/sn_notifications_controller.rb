class SnNotificationsController < ApplicationController
  def create
    id =  params[:sn_subscription_id].to_i
    SnSubscription.find_by(id:)&.tap { it.notify(title: "Test for ID: #{id}", body: "", url: sn_subscriptions_url) }
    redirect_to sn_subscriptions_url
  end
end

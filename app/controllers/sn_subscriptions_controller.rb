class SnSubscriptionsController < ApplicationController
  def index
    @sn_subscriptions = SnSubscription.order(:id)
  end

  def show
    @sn_subscription = SnSubscription.find(params[:id])
  end

  def new
    @sn_subscription = SnSubscription.new
  end

  def create
    @sn_subscription = SnSubscription.new(params.require(:sn_subscription).permit(:endpoint, :p256dh, :auth))
    if @sn_subscription.save
      redirect_to sn_subscriptions_url
    else
      render :new, status: 422
    end
  end

  def destroy
    SnSubscription.find(params[:id]).destroy
    redirect_to sn_subscriptions_url
  end
end

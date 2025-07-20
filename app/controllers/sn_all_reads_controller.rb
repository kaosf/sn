class SnAllReadsController < ApplicationController
  def create
    Sn.unread.update_all(read: 1)
    redirect_to sns_url
  end
end

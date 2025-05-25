class SnReadsController < ApplicationController
  def update
    Sn.where(uuid: params[:id]).update_all(read: 1)
    render json: {}
  end
end

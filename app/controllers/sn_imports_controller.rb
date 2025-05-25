class SnImportsController < ApplicationController
  def create
    if Sn.count.positive?
      @error = "An Sn exists."
      render :new, status: 422
      return
    end
    if params[:file].nil?
      @error = "File not attached."
      render :new, status: 422
      return
    end

    params[:file].tempfile.each_line { Sn.insert(JSON.parse(it)) }
    redirect_to new_sn_import_url
  end
end

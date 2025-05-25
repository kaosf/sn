class SnAllDeletionsController < ApplicationController
  def create
    Sn.delete_all
    redirect_to new_sn_import_url
  end
end

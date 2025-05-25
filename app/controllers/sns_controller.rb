class SnsController < ApplicationController
  def index
    @sns = Sn.ordered_by_time_desc.then { params[:unread] == "1" ? it.unread : it }.page(params[:page]).per(100)
    @unread_count = Sn.unread.count
  end

  def show
    @sn = Sn.find_by!(uuid: params[:id])
    @sn_new, @sn_old, @sn_new_unread, @sn_old_unread = @sn.new_and_old_and_unread_models
  end

  allow_unauthenticated_access only: %i[create]
  skip_forgery_protection only: %i[create]

  def create
    token = request.headers["HTTP_AUTHORIZATION"]&.split(" ")&.then { it[1] } || ""
    begin
      correct_token = ApiToken.correct_token
    rescue StandardError
      return render status: 500, json: { message: "Something went wrong." }
    end
    return render status: 401, json: { message: "Something went wrong." } if token != correct_token

    sn = Sn.new(title: params[:title], body: params[:body])
    if sn.save
      render json: { message: "OK." }
    else
      render status: 422, json: { message: "Something went wrong." }
    end
  rescue StandardError => e
    # :nocov:
    render status: 500, json: { message: "Something went wrong." }
    Rails.logger.error e
    # :nocov:
  end

  # NOTE: curl experiment command
  # source .env && curl -i -H "content-type: application/json" -H "authorization: Bearer api-auth-token" -d '{"title":"Title","body":"Body"}' http://localhost:${PORT}/sns
  # echo '{"title":"Title","body":"Body"}' > body.json && source .env && curl -i -H "content-type: application/json" -H "authorization: Bearer api-auth-token" -d @body.json http://localhost:${PORT}/sns
end

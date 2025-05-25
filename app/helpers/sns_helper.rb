module SnsHelper
  def link_to_sn(sn, title: sn.title)
    if params[:unread] == "1"
      link_to title, sn_path(sn.uuid, unread: "1")
    else
      link_to title, sn_path(sn.uuid)
    end
  end
end

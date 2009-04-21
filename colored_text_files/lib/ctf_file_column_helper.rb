module CtfFileColumnHelper

  def url_for_uv_file_column(object, method, options = nil)
    generic_url(object, method, "." << object.send("#{method}_options")[:uv][:theme] << ".html", options)
  end

  def url_for_uv_column(object, method)
    object.send("#{method}_state").transform_with_uv
    file_suffix = "." << object.send("#{method}_options")[:uv][:theme] << ".html"
    generic_url(object, method, file_suffix, :absolute => true)
  end

end

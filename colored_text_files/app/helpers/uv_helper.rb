module UvHelper

  # A popup is needed since the default link shows file inplace
  def link_to_uv(record, filename)
    link_to(StaticPicture::view, uv_attachment_path(record),
            { :class => 'no_hover' , :popup =>
              [filename, 'height=600,width=800,scrollbars=yes']})
  end

  def path_to_uv(object, method)
    App::FilesPath + url_for_uv_column(object, method)
  end

end

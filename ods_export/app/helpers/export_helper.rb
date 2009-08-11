module ExportHelper

  def issues_export_link
    export_link issues_export_path(:format => :ods)
  end

  def phonecalls_export_link
    export_link phonecalls_export_path(:format => :ods)
  end

  def users_export_link
    export_link users_export_path(:format => :ods)
  end

  def contributions_export_link
    export_link contributions_export_path(:format => :ods)
  end

  def contracts_export_link
    export_link contracts_export_path(:format => :ods)
  end

  private
  # create a link with the images coresponding to the type mime of the export
  def export_link(url)
    style = {:class => 'nobackground'}
    link_to(_('Export in %s') % image_mime_ods, url)
  end
end

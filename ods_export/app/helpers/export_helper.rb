module ExportHelper

  def issues_export_link
    export_link formatted_issues_export_path(:ods)
  end

  def phonecalls_export_link
    export_link formatted_phonecalls_export_path(:ods)
  end

  def users_export_link
    export_link formatted_users_export_path(:ods)
  end

  def contributions_export_link
    export_link formatted_contributions_export_path(:ods)
  end


  private
  # create a link with the images coresponding to the type mime of the export
  def export_link(url)
    style = {:class => 'nobackground'}
    link_to(_('Export in %s') % StaticPicture::mime_ods, url)
  end
end

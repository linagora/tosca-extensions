class Issue < ActiveRecord::Base
  acts_as_reportable

  # Duplicated from init.rb since we want to have all mode of Rails
  # working out of the box
  register_action 'issues_export_link'

  def expert_name
    (engineer ? engineer.name : '-')
  end

  # It's only intended to be used by the export, so there's no check on the
  # presence of this field. See export_controller#compute_issues if you want to
  # see how this method is dynamically created.
  def last_comment_content
    require 'html_utils'
    HtmlUtils.html2text(self.last_comment_text)
  end

  def joined_tags
    self.tag_list.join(', ')
  end

end

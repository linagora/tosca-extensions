class Issue < ActiveRecord::Base
  acts_as_reportable

  # Duplicated from init.rb since we want to have all mode of Rails
  # working out of the box
  register_action 'issues_export_link'

  def expert_name
    (engineer ? engineer.name : '-')
  end
end

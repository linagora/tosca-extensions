class Request < ActiveRecord::Base
  acts_as_reportable

  # Duplicated from init.rb since we want to have all mode of Rails
  # working out of the box
  register_action 'requests_export_link'
end

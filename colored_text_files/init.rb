# gem dependencies #
Rails.configuration.gem 'ultraviolet', :lib => 'uv'

require_plugin 'file_column'

# In order to not have conflict with other extension #
if config.frameworks.include? :action_controller
  Rails.configuration.after_initialize do
    require_dependency 'application'
    AttachmentsController.send :include, CtfAttachmentsController
    IssuesController.send :include, CtfIssuesController
    CommentsController.send :include, CtfCommentsController
    require_dependency 'attachment'

    ActiveRecord::Base.send :extend, CtfFileColumn
    # This one is located in lib/ctf_file_column.rb
    FileColumn::BaseUploadedFile.send :include, CtfBaseUploadedFile

    if config.frameworks.include? :action_view
      ActionView::Base.send(:include, CtfFileColumnHelper)
    end
  end
end

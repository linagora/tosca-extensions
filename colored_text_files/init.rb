# gem dependencies #
Rails.configuration.gem 'ultraviolet', :lib => 'uv'

require_plugin 'file_column'

ActiveRecord::Base.send :extend, CtfFileColumn
# This one is located in lib/ctf_file_column.rb
FileColumn::BaseUploadedFile.send :include, CtfBaseUploadedFile
ActionView::Base.send :include, CtfFileColumnHelper


# In order to not have conflict with other extension #
Rails.configuration.after_initialize do
  require_dependency 'application'
  AttachmentsController.send :include, CtfAttachmentsController
  RequestsController.class_eval { helper :uv }
end

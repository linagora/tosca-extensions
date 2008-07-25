# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

require 'uv'
class ColoredTextFilesExtension < Tosca::Extension
  version "1.0"
  description "Color attached text files with ultra violet"
  url "http://tosca-project.net"

  define_routes do |map|
    map.named_route 'uv_attachment', "/attachments/:id/uv/",
      :controller => 'attachments', :action => 'uv', :method => :get
  end

  def activate
    ActiveRecord::Base.send :extend, CtfFileColumn
    # This one is located in lib/ctf_file_column.rb
    FileColumn::BaseUploadedFile.send :include, CtfBaseUploadedFile
    ActionView::Base.send :include, CtfFileColumnHelper

    Attachment.send :include, CtfAttachment
    AttachmentsController.send :include, CtfAttachmentsController
    DemandesController.class_eval { helper :uv }
  end

  # Todo : Find a way to unload an included module
  def deactivate
  end

end

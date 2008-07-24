# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ColoredTextFilesExtension < Tosca::Extension
  version "1.0"
  description "Color attached text files with ultra violet"
  url "http://tosca-project.net"

  define_routes do |map|
    map.named_route 'uv_attachment', "/attachments/:id/uv/",
      :controller => 'attachments', :action => 'uv', :method => :get
  end

  def activate
    Attachment.class_eval do
      include CtfAttachment
    end
    AttachmentsController.class_eval do
      include CtfAttachmentsController
    end
    DemandesController.class_eval do
      helper :uv
    end
  end

  # Todo : Find a way to unload an included module
  def deactivate
  end

end

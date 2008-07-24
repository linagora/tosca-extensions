module CtfAttachmentsController
  def self.included(base)
    base.class_eval {
      helper :uv
    }
  end


  def uv
    @pj = Attachment.find(params[:id])
    render :partial => "uv"
  end
end

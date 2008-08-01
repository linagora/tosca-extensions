class AttachmentsController < ApplicationController
  helper :uv

  def uv
    @pj = Attachment.find(params[:id])
    render :partial => "uv"
  end
end

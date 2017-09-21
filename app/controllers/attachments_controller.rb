class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  
  def destroy
    if current_user.author_of?(attachment.attachable)
      attachment.destroy
      flash.now[:notice] = 'File deleted'
    else
      flash.now[:alert] = 'You are not the author.'
    end
  end

  private 

  def attachment
    @attachment ||=Attachment.find(params[:id])
  end
end
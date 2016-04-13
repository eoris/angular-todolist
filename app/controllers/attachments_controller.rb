class AttachmentsController < ApplicationController
  load_and_authorize_resource :comment
  load_and_authorize_resource :attachment, through: :comment, shallow: true

  def create
    if @attachment.save
      render json: @attachment
    else
      render json: {:errors => @attachment.errors.full_messages}
    end
  end

  def destroy
    @attachment.destroy
    render json: @attachment
  end

  private

  def attachment_params
    params.permit(:file)
  end
end

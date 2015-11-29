class RedactorRails::PicturesController < ApplicationController

  def index
    @pictures = RedactorRails.picture_model.where(
        RedactorRails.picture_model.new.respond_to?(RedactorRails.devise_user) ? { RedactorRails.devise_user_key => redactor_current_user.id } : { })
    render :json => @pictures.to_json
  end

  def create
    @picture = RedactorRails.picture_model.new

    file = params[:file]
    @picture.data = RedactorRails::Http.normalize_param(file, request)

    if @picture.save
      render json: { link: @picture.url(:content), id: @picture.id }
    else
      render json: { error: @picture.errors }
    end
  end

  private

end

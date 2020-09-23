class Api::V1::BackgroundController < ApplicationController
  def index
    if params[:location].nil? || params[:location].empty?
      render json: ErrorSerializer.new(ErrorHandler.new('Location parameters cannot be blank')), status: :bad_request
    else
      render json: ImageSerializer.new(BackgroundImageData.new(BackgroundFacade.image_data(params[:location]))), status: :ok
    end
  end
end

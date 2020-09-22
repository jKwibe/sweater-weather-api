class Api::V1::BackgroundController < ApplicationController
  def index
    if params[:location].nil? || params[:location].empty?
      render json: ErrorSerializer.new(ErrorHandler.new('Location parameters cannot be blank')), status: :unprocessable_entity
    else
      render json: ImageSerializer.new(BackgroundFacade.new(params[:location]))
    end
  end
end

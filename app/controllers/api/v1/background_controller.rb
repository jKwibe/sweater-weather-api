class Api::V1::BackgroundController < ApplicationController
  def index
    render json: ImageSerializer.new(BackgroundFacade.new(params[:location]))
  end
end

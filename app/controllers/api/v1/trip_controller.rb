class Api::V1::TripController < ApplicationController
  before_action :authorize
  def create
    if (params[:origin].nil? || params[:origin].empty?) || (params[:destination].nil? || params[:destination].empty?)
      render json: ErrorSerializer.new(ErrorHandler.new('Must have both origin and destination fields')), status: :unprocessable_entity
    else
      render json: TripSerializer.new(TripFacade.new(params[:origin], params[:destination])), status: :ok
    end
  end
end

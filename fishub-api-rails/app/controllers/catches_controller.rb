class CatchesController < ApplicationController
  before_action :authenticate_user
  before_action :set_bait

  def index
    @catches = current_user.catches.where(bait: @bait)
  end

  def create
    @catch = current_user.catches.new(catch_params)
    @catch.bait = @bait
    if @catch.save
      render status: :created
    else
      render json: { errors: @catch.errors }, status: :unprocessable_entity
    end
  end

private

  def set_bait
    @bait = Bait.find(params[:bait_id])
  end

  def catch_params
    params.require(:catch).permit(:species, :weight, :length)
  end
end


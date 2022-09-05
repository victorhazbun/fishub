class TackleBoxItemsController < ApplicationController
  before_action :authenticate_user

  def index
    @items = current_user.tackle_box_items.includes(:bait)
  end

  def create
    @item = current_user.tackle_box_items.new(item_params)
    if @item.save
      render status: :created
    else
      render json: { errors: @item.errors }, status: :unprocessable_entity
    end
  end

private

  def item_params
    params.require(:tackle_box_item).permit(:bait_id)
  end
end


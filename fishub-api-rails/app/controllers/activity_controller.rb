class ActivityController < ApplicationController  
  def index
    @catches = Catch.all.includes(:bait, :user)
  end
end


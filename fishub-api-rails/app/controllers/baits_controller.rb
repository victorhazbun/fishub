class BaitsController < ApplicationController  
  def index
    @baits = Bait.all
  end
end

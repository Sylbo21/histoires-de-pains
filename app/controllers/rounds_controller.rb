class RoundsController < ApplicationController

  def index
    @locations = Location.all
  end

end

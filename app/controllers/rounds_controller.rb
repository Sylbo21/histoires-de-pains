class RoundsController < ApplicationController

  def index
    @locations = Location.all
    @rounds = Round.all
  end

end

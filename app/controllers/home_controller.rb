class HomeController < ApplicationController
  def index
    @batches = Batch.very_next_ones
  end
end

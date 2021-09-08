class HomeController < ApplicationController
  def index
    @batches = Batch.next
  end
end

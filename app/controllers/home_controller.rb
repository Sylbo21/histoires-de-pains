class HomeController < ApplicationController
  def index
    @batches = Batches.next
  end
end

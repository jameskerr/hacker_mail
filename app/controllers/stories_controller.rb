class StoriesController < ApplicationController
  def index
    @stories = Story.last(30)
  end

  def show
    @story = Story.find(params[:id])
  end
end

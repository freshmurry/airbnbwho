class PagesController < ApplicationController
  def home
    @rooms = Room.where(active: true).limit(1).includes(:photos)
    @current_user = current_user
  end
end
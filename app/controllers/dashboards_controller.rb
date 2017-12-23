class DashboardsController < ApplicationController
  def show
    @games = Game.all
  end
end

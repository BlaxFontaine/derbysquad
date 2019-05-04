class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.all
  end



  private

  def set_team
    @team = Team.find(params[:id])
  end
end

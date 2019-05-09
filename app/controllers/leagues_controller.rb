class LeaguesController < ApplicationController
  def index
    @leagues = League.all
    @markers = @leagues.map do |league|
      {
        lat: league.lat,
        lng: league.long,
        infoWindow: render_to_string(partial: "infowindow", locals: { league: league })
      }
    end
  end

  def show
    @league = League.find(params[:id])
    @teams = Team.where(league_id: params[:id])
  end
end

class Api::V1::LeaguesController < ActionController::Base
  def index
    @leagues = League.order(created_at: :desc)
    render json: @leagues
  end

  def show
    @league = League.find(params[:id])
    render json: @league
  end

  def create
    @league = League.create(league_params)
    render json: @league
  end

  private

  def league_params
    params.require(:league).permit(:name, :country, :city, :lat, :long, :logo, :region)
  end
end

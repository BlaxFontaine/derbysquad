class PagesController < ApplicationController
  def home
    @leagues = League.where(region: "Australia")
  end
end

class PagesController < ApplicationController
  def home
    @leagues = League.all
  end
end

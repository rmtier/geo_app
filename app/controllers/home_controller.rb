class HomeController < ApplicationController
  def index
    if params[:search]
      sql = "SELECT  w.tags AS tags, ST_AsGeoJSON(n.geom) FROM #{params[:search][:type]} w
      JOIN nodes n ON n.id = ANY(w.nodes)
      LIMIT 10"
      @results = ActiveRecord::Base.connection.execute sql

    else
      @results = []
    end

    respond_to do |format|
      format.json {render json: @results}
      format.html
    end

  end
end

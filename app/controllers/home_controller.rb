class HomeController < ApplicationController
  def index
    if params[:search]
      sql = "SELECT p.name, ST_AsGeoJSON(ST_Transform(p.#{params[:search][:type]}, 4326)) FROM planet_osm_point p
      WHERE p.name
      LIMIT 100"
      @results = ActiveRecord::Base.connection.execute sql

    else
      @results = []
    end

    respond_to do |format|
      format.json {render json: @results}
      format.html
    end
  end

  def search_points
    if params[:search_coord]

      filter_string = ""

      if params[:search_coord][:type] == "All"
        filter_string = ""
      elsif params[:search_coord][:type] == "Unknown"
        filter_string += "AND coalesce(p.name, '') = ''"
      else
        filter_string += "AND coalesce(p.name, '') != ''"
      end

      sql = "SELECT p.name, ST_AsGeoJSON(ST_Transform(p.way, 4326)) FROM planet_osm_point  p
           WHERE ST_Contains(ST_MakePolygon(ST_GeomFromText('LINESTRING(#{params[:search_coord][:min_x]} #{params[:search_coord][:min_y]},
                                                                        #{params[:search_coord][:max_x]} #{params[:search_coord][:min_y]},
                                                                        #{params[:search_coord][:max_x]} #{params[:search_coord][:max_y]},
                                                                        #{params[:search_coord][:min_x]} #{params[:search_coord][:max_y]},
                                                                        #{params[:search_coord][:min_x]} #{params[:search_coord][:min_y]})', 4326)), ST_Transform(p.way, 4326))
           #{filter_string} LIMIT 1000"
      @results = ActiveRecord::Base.connection.execute sql

    else
      @results = []
    end

    respond_to do |format|
      format.json {render json: @results}
      format.html
    end
  end

  def insert
    if params[:insert_node_form]

    end


    respond_to do |format|
      format.json {render json: @results}
      format.html
    end
  end
end

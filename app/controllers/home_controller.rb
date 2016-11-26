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

  def insert_node
    if params[:insert_node_form]

      sql = "INSERT INTO planet_osm_point (osm_id, name, historic, way) VALUES
        (CAST( (SELECT Max(p.osm_id) FROM planet_osm_point p) AS BIGINT) + 1, '#{params[:insert_node_form][:name]}',
                                                                              '#{params[:insert_node_form][:type]}',
                                              ST_Transform(ST_GeomFromText('POINT(#{params[:insert_node_form][:x]} #{params[:insert_node_form][:y]})', 4326), 900913))
      RETURNING osm_id"

      id = ActiveRecord::Base.connection.execute sql

      sql2 = "SELECT p.name, ST_AsGeoJSON(ST_Transform(p.way, 4326)) FROM planet_osm_point p
      WHERE p.osm_id=#{id[0]['osm_id']} LIMIT 1"

      @results = ActiveRecord::Base.connection.execute sql2
    else
      @results = []
    end


    respond_to do |format|
      format.json {render json: @results}
      format.html
    end
  end

  def search_points_historic
    if params[:search_coord_historic]

      filter_string = ""

      if params[:search_coord_historic][:type] == "castle"
        filter_string += "AND coalesce(p.historic, '') = 'castle'"

      elsif params[:search_coord_historic][:type] == "battlefield"
        filter_string += "AND coalesce(p.historic, '') = 'battlefield'"

      elsif params[:search_coord_historic][:type] == "unknown"
        filter_string += "AND coalesce(p.historic, '') != 'castle'
                          AND coalesce(p.historic, '') != 'battlefield'
                          AND coalesce(p.historic, '') != 'memorial'
                          AND coalesce(p.historic, '') != 'monument'
                          AND coalesce(p.historic, '') != 'archaeological_site'
                          AND coalesce(p.historic, '') != 'bondary_stone'"

      elsif params[:search_coord_historic][:type] == "memorial"
        filter_string += "AND coalesce(p.historic, '') = 'memorial'"

      elsif params[:search_coord_historic][:type] == "monument"
        filter_string += "AND coalesce(p.historic, '') = 'monument'"

      elsif params[:search_coord_historic][:type] == "archaeological_site"
        filter_string += "AND coalesce(p.historic, '') = 'archaeological_site'"

      elsif params[:search_coord_historic][:type] == 'bondary_stone'
        filter_string += "AND coalesce(p.historic, '') = 'bondary_stone'"

      end

      sql = "SELECT p.name, p.historic, ST_AsGeoJSON(ST_Transform(p.way, 4326)) FROM planet_osm_point  p
           WHERE ST_Contains(ST_MakePolygon(ST_GeomFromText('LINESTRING(#{params[:search_coord_historic][:min_x]} #{params[:search_coord_historic][:min_y]},
                                                                        #{params[:search_coord_historic][:max_x]} #{params[:search_coord_historic][:min_y]},
                                                                        #{params[:search_coord_historic][:max_x]} #{params[:search_coord_historic][:max_y]},
                                                                        #{params[:search_coord_historic][:min_x]} #{params[:search_coord_historic][:max_y]},
                                                                        #{params[:search_coord_historic][:min_x]} #{params[:search_coord_historic][:min_y]})', 4326)), ST_Transform(p.way, 4326))
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
end

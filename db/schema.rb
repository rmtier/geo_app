# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "hstore"

  create_table "actions", primary_key: ["data_type", "id"], force: :cascade do |t|
    t.string "data_type", limit: 1, null: false
    t.string "action",    limit: 1, null: false
    t.bigint "id",                  null: false
  end

# Could not dump table "planet_osm_line" because of following StandardError
#   Unknown type 'geometry(LineString,900913)' for column 'way'

  create_table "planet_osm_nodes", id: :bigint, force: :cascade do |t|
    t.integer "lat",  null: false
    t.integer "lon",  null: false
    t.text    "tags",              array: true
  end

# Could not dump table "planet_osm_point" because of following StandardError
#   Unknown type 'geometry(Point,900913)' for column 'way'

# Could not dump table "planet_osm_polygon" because of following StandardError
#   Unknown type 'geometry(Geometry,900913)' for column 'way'

  create_table "planet_osm_rels", id: :bigint, force: :cascade do |t|
    t.integer "way_off", limit: 2
    t.integer "rel_off", limit: 2
    t.bigint  "parts",                          array: true
    t.text    "members",                        array: true
    t.text    "tags",                           array: true
    t.boolean "pending",           null: false
    t.index ["id"], name: "planet_osm_rels_idx", where: "pending", using: :btree
    t.index ["parts"], name: "planet_osm_rels_parts", using: :gin
  end

# Could not dump table "planet_osm_roads" because of following StandardError
#   Unknown type 'geometry(LineString,900913)' for column 'way'

  create_table "planet_osm_ways", id: :bigint, force: :cascade do |t|
    t.bigint  "nodes",   null: false, array: true
    t.text    "tags",                 array: true
    t.boolean "pending", null: false
    t.index ["id"], name: "planet_osm_ways_idx", where: "pending", using: :btree
    t.index ["nodes"], name: "planet_osm_ways_nodes", using: :gin
  end

  create_table "relation_members", primary_key: ["relation_id", "sequence_id"], force: :cascade do |t|
    t.bigint  "relation_id",           null: false
    t.bigint  "member_id",             null: false
    t.string  "member_type", limit: 1, null: false
    t.text    "member_role",           null: false
    t.integer "sequence_id",           null: false
    t.index ["member_id", "member_type"], name: "idx_relation_members_member_id_and_type", using: :btree
  end

  create_table "relations", id: :bigint, force: :cascade do |t|
    t.integer  "version",      null: false
    t.integer  "user_id",      null: false
    t.datetime "tstamp",       null: false
    t.bigint   "changeset_id", null: false
    t.hstore   "tags"
  end

  create_table "schema_info", primary_key: "version", id: :integer, force: :cascade do |t|
  end

  create_table "spatial_ref_sys", primary_key: "srid", id: :integer, force: :cascade do |t|
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

end

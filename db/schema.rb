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

# Could not dump table "nodes" because of following StandardError
#   Unknown type 'geometry(Point,4326)' for column 'geom'

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

  create_table "users", id: :integer, force: :cascade do |t|
    t.text "name", null: false
  end

  create_table "way_nodes", primary_key: ["way_id", "sequence_id"], force: :cascade do |t|
    t.bigint  "way_id",      null: false
    t.bigint  "node_id",     null: false
    t.integer "sequence_id", null: false
    t.index ["node_id"], name: "idx_way_nodes_node_id", using: :btree
  end

# Could not dump table "ways" because of following StandardError
#   Unknown type 'geometry(Geometry,4326)' for column 'bbox'

end

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

ActiveRecord::Schema.define(version: 20161112000000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id",         null: false
    t.integer  "question_set_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["question_set_id"], name: "index_favorites_on_question_set_id", using: :btree
    t.index ["user_id", "question_set_id"], name: "index_favorites_on_user_id_and_question_set_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_favorites_on_user_id", using: :btree
  end

  create_table "parties", force: :cascade do |t|
    t.string   "name",           default: "未登録",        null: false
    t.integer  "status",         default: 1,            null: false
    t.date     "established_on", default: '2016-10-29', null: false
    t.date     "dissolved_on"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "question_scores", force: :cascade do |t|
    t.integer  "question_id",           null: false
    t.integer  "party_id",              null: false
    t.integer  "agree",       limit: 2, null: false
    t.integer  "neutral",     limit: 2, null: false
    t.integer  "opposition",  limit: 2, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["party_id"], name: "index_question_scores_on_party_id", using: :btree
    t.index ["question_id", "party_id"], name: "index_question_scores_on_question_id_and_party_id", unique: true, using: :btree
    t.index ["question_id"], name: "index_question_scores_on_question_id", using: :btree
  end

  create_table "question_set_relationships", force: :cascade do |t|
    t.integer  "question_set_id"
    t.integer  "question_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["question_id"], name: "index_question_set_relationships_on_question_id", using: :btree
    t.index ["question_set_id", "question_id"], name: "question_set_index", unique: true, using: :btree
    t.index ["question_set_id"], name: "index_question_set_relationships_on_question_set_id", using: :btree
  end

  create_table "question_sets", force: :cascade do |t|
    t.integer  "user_id",                          null: false
    t.string   "title",                            null: false
    t.integer  "status",     limit: 2, default: 0, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["user_id"], name: "index_question_sets_on_user_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "question_scores", "parties"
  add_foreign_key "question_scores", "questions"
  add_foreign_key "question_sets", "users"
  add_foreign_key "questions", "users"
end

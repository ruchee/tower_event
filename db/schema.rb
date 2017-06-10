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

ActiveRecord::Schema.define(version: 20170609013800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "accesses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false, comment: "用户ID"
    t.uuid "team_id", null: false, comment: "团队ID"
    t.integer "role", default: 0, comment: "权限角色"
    t.uuid "access_projects", default: [], comment: "参与的项目", array: true
    t.uuid "access_calendars", default: [], comment: "可访问的日历", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role"], name: "index_accesses_on_role"
    t.index ["team_id"], name: "index_accesses_on_team_id"
    t.index ["user_id", "team_id"], name: "index_accesses_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_accesses_on_user_id"
  end

  create_table "comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "parent_id", comment: "父评论ID"
    t.string "subject_model", null: false, comment: "回复主体模型"
    t.uuid "subject_id", null: false, comment: "回复主体ID"
    t.uuid "user_id", null: false, comment: "用户ID"
    t.text "content", null: false, comment: "评论内容"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false, comment: "参与人"
    t.string "action", null: false, comment: "动作"
    t.string "action_model", null: false, comment: "动作关联模型"
    t.uuid "action_id", null: false, comment: "动作关联ID"
    t.uuid "project_id", comment: "所属项目ID"
    t.uuid "team_id", null: false, comment: "所属团队ID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_events_on_project_id"
    t.index ["team_id"], name: "index_events_on_team_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "projects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "team_id", null: false, comment: "团队ID"
    t.uuid "user_id", null: false, comment: "项目创建者"
    t.string "name", null: false, comment: "项目名称"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_projects_on_team_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "teams", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false, comment: "团队创建者"
    t.string "name", null: false, comment: "团队名称"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "todos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "project_id", null: false, comment: "项目ID"
    t.uuid "user_id", null: false, comment: "任务创建者"
    t.string "name", null: false, comment: "任务名称"
    t.uuid "assignee", comment: "任务指派给的人"
    t.date "due_date", comment: "任务截止时间"
    t.integer "status", default: 0, comment: "任务状态"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_todos_on_project_id"
    t.index ["status"], name: "index_todos_on_status"
    t.index ["user_id"], name: "index_todos_on_user_id"
  end

  create_table "user_teams", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false, comment: "用户ID"
    t.uuid "team_id", null: false, comment: "团队ID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_user_teams_on_team_id"
    t.index ["user_id", "team_id"], name: "index_user_teams_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_user_teams_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false, comment: "邮箱"
    t.string "nickname", null: false, comment: "昵称"
    t.string "avatar", comment: "头像"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end

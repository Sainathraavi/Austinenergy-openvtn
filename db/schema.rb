# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140827140330) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "account_number",  limit: 255
    t.string   "company",         limit: 255
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "phone",           limit: 255
    t.string   "contact2",        limit: 255
    t.string   "contact3",        limit: 255
    t.string   "contact4",        limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "remember_token",  limit: 255
    t.boolean  "is_admin"
  end

  add_index "accounts", ["remember_token"], name: "index_accounts_on_remember_token", using: :btree

  create_table "create_reports", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "description",   limit: 255
    t.string   "request_id",    limit: 255
    t.integer  "ven_id",        limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "active"
    t.boolean  "create_queued"
    t.boolean  "cancel_queued"
  end

  create_table "currency_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "current_values", force: :cascade do |t|
    t.integer  "value",       limit: 4
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "data_qualities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "emix_units", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "description",      limit: 255
    t.string   "custom_units",     limit: 255
    t.decimal  "hertz",                        precision: 10
    t.decimal  "voltage",                      precision: 10
    t.boolean  "ac"
    t.integer  "si_scale_code_id", limit: 4
    t.integer  "unit_type_id",     limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "currency_type_id", limit: 4
  end

  create_table "end_device_assets", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "end_device_assets", ["name"], name: "index_end_device_assets_on_name", unique: true, using: :btree

  create_table "event_groups", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.integer  "group_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "event_groups", ["event_id", "group_id"], name: "event_groups_unique", unique: true, using: :btree
  add_index "event_groups", ["event_id"], name: "index_event_groups_on_event_id", using: :btree
  add_index "event_groups", ["group_id"], name: "index_event_groups_on_group_id", using: :btree

  create_table "event_opts", force: :cascade do |t|
    t.string   "opt_id",                    limit: 255
    t.string   "request_id",                limit: 255
    t.integer  "event_modification_number", limit: 4
    t.integer  "ven_id",                    limit: 4
    t.integer  "resource_id",               limit: 4
    t.integer  "event_id",                  limit: 4
    t.integer  "opt_type_id",               limit: 4
    t.integer  "opt_reason_id",             limit: 4
    t.integer  "market_context_id",         limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "is_create_opt"
  end

  add_index "event_opts", ["event_id"], name: "index_event_opts_on_event_id", using: :btree
  add_index "event_opts", ["market_context_id"], name: "index_event_opts_on_market_context_id", using: :btree
  add_index "event_opts", ["opt_reason_id"], name: "index_event_opts_on_opt_reason_id", using: :btree
  add_index "event_opts", ["opt_type_id"], name: "index_event_opts_on_opt_type_id", using: :btree
  add_index "event_opts", ["resource_id"], name: "index_event_opts_on_resource_id", using: :btree
  add_index "event_opts", ["ven_id"], name: "index_event_opts_on_ven_id", using: :btree

  create_table "event_parties", force: :cascade do |t|
    t.integer  "event_id",                       limit: 4
    t.integer  "market_context_subscription_id", limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "event_parties", ["event_id", "market_context_subscription_id"], name: "event_parties_unique", unique: true, using: :btree
  add_index "event_parties", ["event_id"], name: "index_event_parties_on_event_id", using: :btree
  add_index "event_parties", ["market_context_subscription_id"], name: "index_event_parties_on_market_context_subscription_id", using: :btree

  create_table "event_resources", force: :cascade do |t|
    t.integer  "event_id",         limit: 4
    t.integer  "resource_type_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "event_resources", ["event_id", "resource_type_id"], name: "event_resources_unique", unique: true, using: :btree
  add_index "event_resources", ["event_id"], name: "index_event_resources_on_event_id", using: :btree
  add_index "event_resources", ["resource_type_id"], name: "index_event_resources_on_resource_type_id", using: :btree

  create_table "event_responses", force: :cascade do |t|
    t.string   "response_code",        limit: 255
    t.string   "response_description", limit: 255
    t.string   "request_id",           limit: 255
    t.integer  "modification_number",  limit: 4
    t.string   "opt_type",             limit: 255
    t.integer  "event_id",             limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "ven_id",               limit: 4
  end

  add_index "event_responses", ["event_id"], name: "index_event_responses_on_event_id", using: :btree

  create_table "event_signal_intervals", force: :cascade do |t|
    t.integer  "duration",        limit: 4
    t.integer  "uid",             limit: 4
    t.integer  "payload_type_id", limit: 4
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "event_signal_id", limit: 4
    t.datetime "dtstart"
    t.decimal  "payload",                    precision: 13, scale: 3
    t.float    "payload_a",       limit: 24
  end

  add_index "event_signal_intervals", ["event_signal_id"], name: "index_event_signal_intervals_on_event_signal_id", using: :btree

  create_table "event_signals", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.integer  "signal_type_id",      limit: 4
    t.string   "signal_id",           limit: 255
    t.integer  "event_id",            limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "signal_name_id",      limit: 4
    t.integer  "emix_unit_id",        limit: 4
    t.boolean  "baseline"
    t.string   "baseline_id",         limit: 255
    t.string   "baseline_name",       limit: 255
    t.datetime "dtstart"
    t.integer  "duration",            limit: 4
    t.integer  "end_device_asset_id", limit: 4
  end

  add_index "event_signals", ["event_id"], name: "index_event_signals_on_event_id", using: :btree

  create_table "event_statuses", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "description", limit: 255
  end

  create_table "event_vens", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.integer  "ven_id",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "event_vens", ["event_id", "ven_id"], name: "event_vens_unique", unique: true, using: :btree
  add_index "event_vens", ["event_id"], name: "index_event_vens_on_event_id", using: :btree
  add_index "event_vens", ["ven_id"], name: "index_event_vens_on_ven_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "event_id",                  limit: 255
    t.integer  "modification_number",       limit: 4
    t.integer  "priority",                  limit: 4
    t.integer  "market_context_id",         limit: 4
    t.integer  "event_status_id",           limit: 4
    t.string   "test_event",                limit: 255
    t.string   "vtn_comment",               limit: 255
    t.datetime "dtstart"
    t.integer  "duration",                  limit: 4
    t.integer  "tolerance",                 limit: 4
    t.integer  "ei_notification",           limit: 4
    t.integer  "ei_rampup",                 limit: 4
    t.integer  "ei_recovery",               limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "response_required_type_id", limit: 4
    t.boolean  "template"
    t.integer  "schedule_id",               limit: 4
    t.boolean  "published"
    t.text     "payload",                   limit: 65535
    t.integer  "account_id",                limit: 4
  end

  create_table "group_members", force: :cascade do |t|
    t.integer  "group_id",   limit: 4
    t.integer  "account_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "group_members", ["account_id", "group_id"], name: "index_group_members_on_account_id_and_group_id", unique: true, using: :btree
  add_index "group_members", ["account_id"], name: "index_group_members_on_account_id", using: :btree
  add_index "group_members", ["group_id"], name: "index_group_members_on_group_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "intervals", force: :cascade do |t|
    t.datetime "dtstart"
    t.string   "duration",   limit: 255
    t.integer  "uid",        limit: 4
    t.text     "payload",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "market_context_subscriptions", force: :cascade do |t|
    t.integer  "market_context_id", limit: 4
    t.integer  "ven_id",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "party_name",        limit: 255
  end

  add_index "market_context_subscriptions", ["market_context_id", "ven_id"], name: "mkt_ctxt_mkt_ct_id_ven_id", unique: true, using: :btree
  add_index "market_context_subscriptions", ["market_context_id"], name: "index_market_context_subscriptions_on_market_context_id", using: :btree
  add_index "market_context_subscriptions", ["ven_id"], name: "index_market_context_subscriptions_on_ven_id", using: :btree

  create_table "market_contexts", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "oadr_test_cases", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "target",     limit: 255
    t.string   "version",    limit: 255
    t.string   "direction",  limit: 255
  end

  create_table "opt_reasons", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "opt_schedule_durations", force: :cascade do |t|
    t.datetime "dtstart"
    t.string   "duration",        limit: 255
    t.string   "tolerance",       limit: 255
    t.string   "ei_notification", limit: 255
    t.string   "ei_ramp_up",      limit: 255
    t.string   "ei_recovery",     limit: 255
    t.integer  "opt_schedule_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "opt_schedule_durations", ["opt_schedule_id"], name: "index_opt_schedule_durations_on_opt_schedule_id", using: :btree

  create_table "opt_schedules", force: :cascade do |t|
    t.string   "request_id",        limit: 255
    t.string   "opt_id",            limit: 255
    t.integer  "opt_type_id",       limit: 4
    t.integer  "opt_reason_id",     limit: 4
    t.integer  "market_context_id", limit: 4
    t.integer  "ven_id",            limit: 4
    t.integer  "resource_id",       limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "active"
  end

  add_index "opt_schedules", ["market_context_id"], name: "index_opt_schedules_on_market_context_id", using: :btree
  add_index "opt_schedules", ["opt_reason_id"], name: "index_opt_schedules_on_opt_reason_id", using: :btree
  add_index "opt_schedules", ["opt_type_id"], name: "index_opt_schedules_on_opt_type_id", using: :btree
  add_index "opt_schedules", ["resource_id"], name: "index_opt_schedules_on_resource_id", using: :btree
  add_index "opt_schedules", ["ven_id"], name: "index_opt_schedules_on_ven_id", using: :btree

  create_table "opt_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "payload_types", force: :cascade do |t|
    t.integer  "value",      limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pet", id: false, force: :cascade do |t|
    t.string "name",    limit: 20
    t.string "owner",   limit: 20
    t.string "species", limit: 20
    t.string "sex",     limit: 1
    t.date   "birth"
    t.date   "death"
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "reading_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.string   "request_id",             limit: 255
    t.string   "registration_id",        limit: 255
    t.string   "ven_name",               limit: 255
    t.string   "oadr_profile_name",      limit: 255
    t.string   "oadr_transport_name",    limit: 255
    t.string   "oadr_transport_address", limit: 255
    t.boolean  "oadr_report_only"
    t.boolean  "oadr_xml_signature"
    t.string   "oadr_ven_name",          limit: 255
    t.boolean  "oadr_http_pull_model"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "ven_id",                 limit: 4
  end

  create_table "report_instances", force: :cascade do |t|
    t.string   "report_request_id", limit: 255
    t.datetime "dtstart"
    t.string   "duration",          limit: 255
    t.string   "created_date_time", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "ei_report_id",      limit: 255
    t.integer  "report_id",         limit: 4
  end

  create_table "report_interval_descriptions", force: :cascade do |t|
    t.string   "rid",                      limit: 255
    t.string   "report_subject",           limit: 255
    t.string   "report_data_source",       limit: 255
    t.integer  "report_type_id",           limit: 4
    t.string   "emix_item",                limit: 255
    t.integer  "reading_type_id",          limit: 4
    t.string   "market_context",           limit: 255
    t.string   "sampling_rate_min_period", limit: 255
    t.string   "sampling_rate_max_period", limit: 255
    t.boolean  "sampling_rate_on_change"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "report_id",                limit: 4
  end

  add_index "report_interval_descriptions", ["reading_type_id"], name: "index_interval_report_descriptions_on_reading_type_id", using: :btree
  add_index "report_interval_descriptions", ["report_type_id"], name: "index_interval_report_descriptions_on_report_type_id", using: :btree

  create_table "report_intervals", force: :cascade do |t|
    t.string   "rid",                            limit: 255
    t.integer  "confidence",                     limit: 4
    t.float    "accuracy",                       limit: 24
    t.integer  "data_quality_id",                limit: 4
    t.float    "value",                          limit: 24
    t.integer  "resource_status_id",             limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "online"
    t.boolean  "manual_override"
    t.datetime "dtstart"
    t.string   "duration",                       limit: 255
    t.integer  "uid",                            limit: 4
    t.integer  "report_instance_id",             limit: 4
    t.integer  "report_interval_description_id", limit: 4
  end

  add_index "report_intervals", ["data_quality_id"], name: "index_interval_report_payloads_on_data_quality_id", using: :btree
  add_index "report_intervals", ["resource_status_id"], name: "index_interval_report_payloads_on_resource_status_id", using: :btree

  create_table "report_names", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "report_request_descriptions", force: :cascade do |t|
    t.integer  "report_request_id",              limit: 4
    t.integer  "report_interval_description_id", limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "report_request_descriptions", ["report_interval_description_id"], name: "idx_report_interval_description_id", using: :btree
  add_index "report_request_descriptions", ["report_request_id"], name: "idx_report_request_id", using: :btree

  create_table "report_requests", force: :cascade do |t|
    t.string   "request_id",           limit: 255
    t.integer  "granularity",          limit: 4
    t.integer  "report_back_duration", limit: 4
    t.datetime "dtstart"
    t.integer  "duration",             limit: 4
    t.integer  "report_id",            limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "create_report_id",     limit: 4
    t.boolean  "is_metadata"
  end

  add_index "report_requests", ["report_id"], name: "index_report_requests_on_report_id", using: :btree

  create_table "report_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "reports", force: :cascade do |t|
    t.string   "report_specifier_id", limit: 255
    t.datetime "created_date_time"
    t.string   "report_request_id",   limit: 255
    t.string   "duration",            limit: 255
    t.integer  "report_name_id",      limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "ven_id",              limit: 4
  end

  add_index "reports", ["report_name_id"], name: "index_reports_on_report_name_id", using: :btree

  create_table "resource_statuses", force: :cascade do |t|
    t.boolean  "online"
    t.boolean  "manual_override"
    t.float    "capacity_min",               limit: 24
    t.float    "capacity_max",               limit: 24
    t.float    "capacity_current",           limit: 24
    t.float    "capacity_normal",            limit: 24
    t.float    "level_offset_min",           limit: 24
    t.float    "level_offset_max",           limit: 24
    t.float    "level_offset_current",       limit: 24
    t.float    "level_offset_normal",        limit: 24
    t.float    "percent_offset_min",         limit: 24
    t.float    "percent_offset_max",         limit: 24
    t.float    "percent_offset_current",     limit: 24
    t.float    "percent_offset_normal",      limit: 24
    t.float    "set_point_min",              limit: 24
    t.float    "set_point_max",              limit: 24
    t.float    "set_point_current",          limit: 24
    t.float    "set_point_normal",           limit: 24
    t.integer  "resource_id",                limit: 4
    t.integer  "interval_report_payload_id", limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "resource_statuses", ["interval_report_payload_id"], name: "index_resource_statuses_on_interval_report_payload_id", using: :btree
  add_index "resource_statuses", ["resource_id"], name: "index_resource_statuses_on_resource_id", using: :btree

  create_table "resource_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string   "address",                     limit: 255
    t.string   "state",                       limit: 255
    t.integer  "zip",                         limit: 4
    t.string   "geospatial_location",         limit: 255
    t.string   "grid_electrical_coordinates", limit: 255
    t.float    "shed_capability",             limit: 24
    t.integer  "ramp_period",                 limit: 4
    t.integer  "recovery_period",             limit: 4
    t.integer  "ven_id",                      limit: 4
    t.integer  "resource_type_id",            limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "name",                        limit: 255
  end

  add_index "resources", ["resource_type_id"], name: "index_resources_on_resource_type_id", using: :btree
  add_index "resources", ["ven_id"], name: "index_resources_on_ven_id", using: :btree

  create_table "response_required_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "start_time", limit: 4
    t.boolean  "sunday"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.integer  "event_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "comment",    limit: 255
  end

  add_index "schedules", ["event_id"], name: "index_schedules_on_event_id", using: :btree

  create_table "service_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "si_scale_codes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "multiplier",  limit: 4
  end

  create_table "signal_names", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "signal_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "test_case_prompts", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "test_cases",   limit: 255
    t.text     "instructions", limit: 65535
    t.boolean  "ported"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "unit_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "ven_messages", force: :cascade do |t|
    t.text     "oadr_message",    limit: 65535
    t.integer  "ven_id",          limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "service_type_id", limit: 4
  end

  add_index "ven_messages", ["ven_id"], name: "index_ven_messages_on_ven_id", using: :btree

  create_table "ven_polls", force: :cascade do |t|
    t.integer  "ven_id",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "ven_polls", ["created_at"], name: "index_ven_polls_on_created_at", using: :btree
  add_index "ven_polls", ["ven_id"], name: "index_ven_polls_on_ven_id", using: :btree

  create_table "vens", force: :cascade do |t|
    t.string   "name",                        limit: 255
    t.string   "email",                       limit: 255
    t.string   "address",                     limit: 255
    t.string   "state",                       limit: 255
    t.integer  "zip",                         limit: 4
    t.string   "geospatial_location",         limit: 255
    t.string   "grid_electrical_coordinates", limit: 255
    t.float    "shed_capability",             limit: 24
    t.integer  "ramp_period",                 limit: 4
    t.integer  "recovery_period",             limit: 4
    t.integer  "account_id",                  limit: 4
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "registration_id",             limit: 4
    t.string   "ven_id",                      limit: 255
    t.string   "common_name",                 limit: 255
    t.text     "distribute_event_payload",    limit: 65535
    t.integer  "profile_id",                  limit: 4
    t.boolean  "http_push"
    t.string   "transport_address",           limit: 255
    t.datetime "last_comm_at"
  end

  add_index "vens", ["account_id"], name: "index_vens_on_account_id", using: :btree
  add_index "vens", ["common_name"], name: "index_vens_on_common_name", unique: true, using: :btree
  add_index "vens", ["ven_id"], name: "index_vens_on_ven_id", unique: true, using: :btree

  create_table "vtn_parameters", force: :cascade do |t|
    t.string   "vtn_name",      limit: 255
    t.integer  "poll_interval", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "ven_id",        limit: 4
  end

end

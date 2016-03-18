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

ActiveRecord::Schema.define(version: 20160317200915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "subdomain",     default: "", null: false
    t.string   "company_name",  default: "", null: false
    t.string   "company_url",   default: ""
    t.string   "company_phone", default: ""
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["subdomain"], :name => "index_accounts_on_subdomain", :unique => true
  end

  create_table "countries", force: :cascade do |t|
    t.string "name",     null: false
    t.string "iso",      null: false
    t.string "slug"
    t.float  "drawdown"
    t.float  "igv"
    t.index ["slug"], :name => "index_countries_on_slug", :unique => true
  end

  create_table "entities", force: :cascade do |t|
    t.string   "name"
    t.string   "corporate_name"
    t.string   "address"
    t.string   "phone"
    t.string   "legal_id"
    t.integer  "country_id"
    t.integer  "type",           default: 0, null: false
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["country_id"], :name => "fk__entities_country_id"
    t.index ["deleted_at"], :name => "index_entities_on_deleted_at"
    t.index ["slug"], :name => "index_entities_on_slug", :unique => true
    t.foreign_key ["country_id"], "countries", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_entities_country_id"
  end

  create_table "clients", force: :cascade do |t|
    t.integer  "entity_id"
    t.integer  "partner_id"
    t.integer  "type",       default: 0, null: false
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["deleted_at"], :name => "index_clients_on_deleted_at"
    t.index ["entity_id"], :name => "fk__clients_entity_id"
    t.index ["partner_id"], :name => "fk__clients_partner_id"
    t.index ["slug"], :name => "index_clients_on_slug", :unique => true
    t.foreign_key ["entity_id"], "entities", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_clients_entity_id"
    t.foreign_key ["partner_id"], "clients", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_clients_partner_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "first_name",                           null: false
    t.string   "last_name",                            null: false
    t.string   "dni"
    t.string   "dni_scan_file_name"
    t.string   "dni_scan_content_type"
    t.integer  "dni_scan_file_size"
    t.datetime "dni_scan_updated_at"
    t.date     "birthday"
    t.string   "email"
    t.integer  "civil_status",             default: 0, null: false
    t.string   "address"
    t.integer  "district"
    t.integer  "gender"
    t.string   "phone"
    t.string   "mobile"
    t.string   "skype"
    t.string   "certificate_file_name"
    t.string   "certificate_content_type"
    t.integer  "certificate_file_size"
    t.datetime "certificate_updated_at"
    t.integer  "position_id"
    t.integer  "extension"
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["deleted_at"], :name => "index_people_on_deleted_at"
    t.index ["position_id"], :name => "fk__people_position_id"
    t.index ["slug"], :name => "index_people_on_slug", :unique => true
    t.foreign_key ["position_id"], "positions", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_people_position_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "leader_id"
    t.integer  "parent_id"
    t.date     "start"
    t.date     "end"
    t.string   "slug"
    t.datetime "deleted_at"
    t.index ["deleted_at"], :name => "index_teams_on_deleted_at"
    t.index ["parent_id"], :name => "fk__teams_parent_id"
    t.index ["slug"], :name => "index_teams_on_slug", :unique => true
    t.foreign_key ["parent_id"], "teams", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_teams_parent_id"
  end

  create_table "collaborators", force: :cascade do |t|
    t.integer  "person_id",                                       null: false
    t.integer  "team_id"
    t.string   "code"
    t.date     "first_day"
    t.integer  "boss_id"
    t.integer  "reference_id"
    t.string   "work_mail"
    t.integer  "type",                                default: 0, null: false
    t.integer  "status",                              default: 0, null: false
    t.float    "salary"
    t.integer  "blood_type",                          default: 0, null: false
    t.string   "allergies"
    t.boolean  "disability"
    t.string   "before_employment_test_file_name"
    t.string   "before_employment_test_content_type"
    t.integer  "before_employment_test_file_size"
    t.datetime "before_employment_test_updated_at"
    t.string   "around_employment_test_file_name"
    t.string   "around_employment_test_content_type"
    t.integer  "around_employment_test_file_size"
    t.datetime "around_employment_test_updated_at"
    t.string   "after_employment_test_file_name"
    t.string   "after_employment_test_content_type"
    t.integer  "after_employment_test_file_size"
    t.datetime "after_employment_test_updated_at"
    t.integer  "insurance",                           default: 0, null: false
    t.string   "insurance_type"
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "qr_code"
    t.integer  "pin_code"
    t.datetime "archived_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["boss_id"], :name => "fk__collaborators_boss_id"
    t.index ["deleted_at"], :name => "index_collaborators_on_deleted_at"
    t.index ["person_id"], :name => "fk__collaborators_person_id"
    t.index ["reference_id"], :name => "fk__collaborators_reference_id"
    t.index ["slug"], :name => "index_collaborators_on_slug", :unique => true
    t.index ["team_id"], :name => "fk__collaborators_team_id"
    t.foreign_key ["boss_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_collaborators_boss_id"
    t.foreign_key ["person_id"], "people", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_collaborators_person_id"
    t.foreign_key ["reference_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_collaborators_reference_id"
    t.foreign_key ["team_id"], "teams", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_collaborators_team_id"
  end

  create_table "collaborator_entities", force: :cascade do |t|
    t.integer  "collaborator_id"
    t.integer  "entity_id"
    t.integer  "type",            default: 0, null: false
    t.string   "account_number"
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["collaborator_id"], :name => "fk__collaborator_entities_collaborator_id"
    t.index ["deleted_at"], :name => "index_collaborator_entities_on_deleted_at"
    t.index ["entity_id"], :name => "fk__collaborator_entities_entity_id"
    t.foreign_key ["collaborator_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_collaborator_entities_collaborator_id"
    t.foreign_key ["entity_id"], "entities", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_collaborator_entities_entity_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "client_id",   null: false
    t.string   "name"
    t.string   "description"
    t.datetime "deleted_at"
    t.integer  "account_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["account_id"], :name => "fk__projects_account_id"
    t.index ["client_id"], :name => "fk__projects_client_id"
    t.foreign_key ["account_id"], "accounts", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_projects_account_id"
    t.foreign_key ["client_id"], "clients", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_projects_client_id"
  end

  create_table "collaborator_projects", force: :cascade do |t|
    t.integer  "collaborator_id"
    t.integer  "project_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["collaborator_id"], :name => "fk__collaborator_projects_collaborator_id"
    t.index ["project_id"], :name => "fk__collaborator_projects_project_id"
    t.foreign_key ["collaborator_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_collaborator_projects_collaborator_id"
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_collaborator_projects_project_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "client_id"
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "position"
    t.index ["client_id"], :name => "fk__contacts_client_id"
    t.index ["deleted_at"], :name => "index_contacts_on_deleted_at"
    t.index ["person_id"], :name => "fk__contacts_person_id"
    t.index ["slug"], :name => "index_contacts_on_slug", :unique => true
    t.foreign_key ["client_id"], "clients", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_contacts_client_id"
    t.foreign_key ["person_id"], "people", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_contacts_person_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
  end

  create_table "prospects", force: :cascade do |t|
    t.integer  "client_id",                     null: false
    t.integer  "account_id"
    t.integer  "country_id"
    t.integer  "type",              default: 0, null: false
    t.integer  "team_id"
    t.integer  "status",            default: 0, null: false
    t.string   "observation"
    t.date     "approved_at"
    t.string   "name",                          null: false
    t.date     "arrival_date"
    t.date     "arrival_team_date"
    t.datetime "deleted_at"
    t.string   "slug"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["account_id"], :name => "fk__prospects_account_id"
    t.index ["client_id"], :name => "fk__prospects_client_id"
    t.index ["country_id"], :name => "fk__prospects_country_id"
    t.index ["deleted_at"], :name => "index_prospects_on_deleted_at"
    t.index ["slug"], :name => "index_prospects_on_slug", :unique => true
    t.index ["team_id"], :name => "fk__prospects_team_id"
    t.foreign_key ["account_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_prospects_account_id"
    t.foreign_key ["client_id"], "clients", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_prospects_client_id"
    t.foreign_key ["country_id"], "countries", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_prospects_country_id"
    t.foreign_key ["team_id"], "teams", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_prospects_team_id"
  end

  create_table "technologies", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], :name => "index_technologies_on_deleted_at"
    t.index ["slug"], :name => "index_technologies_on_slug", :unique => true
  end

  create_table "estimations", force: :cascade do |t|
    t.integer  "prospect_id",                         null: false
    t.integer  "technology_id"
    t.integer  "type",                    default: 0, null: false
    t.date     "sent_at"
    t.integer  "developers"
    t.float    "developer_days"
    t.float    "developer_hours"
    t.float    "developer_hours_per_day"
    t.integer  "designers"
    t.float    "designer_days"
    t.float    "designer_hours"
    t.float    "designer_hours_per_day"
    t.integer  "accounts"
    t.float    "account_hours"
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "status"
    t.index ["deleted_at"], :name => "index_estimations_on_deleted_at"
    t.index ["prospect_id"], :name => "fk__estimations_prospect_id"
    t.index ["slug"], :name => "index_estimations_on_slug", :unique => true
    t.index ["technology_id"], :name => "fk__estimations_technology_id"
    t.foreign_key ["prospect_id"], "prospects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_estimations_prospect_id"
    t.foreign_key ["technology_id"], "technologies", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_estimations_technology_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "collaborator_id",                 null: false
    t.boolean  "current",         default: false
    t.string   "name"
    t.date     "start"
    t.date     "finish"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["collaborator_id"], :name => "fk__schedules_collaborator_id"
    t.foreign_key ["collaborator_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_schedules_collaborator_id"
  end

  create_table "event_logs", force: :cascade do |t|
    t.integer  "schedule_id",     null: false
    t.integer  "collaborator_id", null: false
    t.string   "date"
    t.string   "inTime"
    t.string   "outTime"
    t.boolean  "edited"
    t.boolean  "launch",          null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["collaborator_id"], :name => "fk__event_logs_collaborator_id"
    t.index ["schedule_id"], :name => "fk__event_logs_schedule_id"
    t.foreign_key ["collaborator_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_event_logs_collaborator_id"
    t.foreign_key ["schedule_id"], "schedules", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_event_logs_schedule_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer  "schedule_id",    null: false
    t.string   "name"
    t.integer  "last_event_log"
    t.string   "inTime"
    t.string   "outTime"
    t.integer  "day_of_week",    null: false
    t.boolean  "launch"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["schedule_id"], :name => "fk__events_schedule_id"
    t.foreign_key ["schedule_id"], "schedules", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_events_schedule_id"
  end

  create_table "headquarters", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "country_id"
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["country_id"], :name => "fk__headquarters_country_id"
    t.index ["deleted_at"], :name => "index_headquarters_on_deleted_at"
    t.index ["slug"], :name => "index_headquarters_on_slug", :unique => true
    t.foreign_key ["country_id"], "countries", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_headquarters_country_id"
  end

  create_table "operating_systems", force: :cascade do |t|
    t.string   "name"
    t.integer  "type",       default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.string   "name",                            null: false
    t.integer  "collaborator_id"
    t.string   "brand"
    t.string   "writer"
    t.string   "edition"
    t.string   "editorial"
    t.string   "model"
    t.integer  "team_id"
    t.integer  "type",                default: 0, null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
    t.integer  "quantity"
    t.string   "serie"
    t.date     "register_date"
    t.string   "cpu"
    t.integer  "ram"
    t.integer  "hdd"
    t.integer  "storage"
    t.integer  "operating_system_id"
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "code"
    t.index ["collaborator_id"], :name => "fk__inventories_collaborator_id"
    t.index ["deleted_at"], :name => "index_inventories_on_deleted_at"
    t.index ["operating_system_id"], :name => "fk__inventories_operating_system_id"
    t.index ["slug"], :name => "index_inventories_on_slug", :unique => true
    t.index ["team_id"], :name => "fk__inventories_team_id"
    t.foreign_key ["collaborator_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_inventories_collaborator_id"
    t.foreign_key ["operating_system_id"], "operating_systems", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_inventories_operating_system_id"
    t.foreign_key ["team_id"], "teams", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_inventories_team_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.text     "description",                             null: false
    t.integer  "currency_id",                             null: false
    t.float    "amount",                                  null: false
    t.integer  "status",                      default: 0, null: false
    t.boolean  "has_drawdown"
    t.string   "extra"
    t.string   "copy_file_name"
    t.string   "copy_content_type"
    t.integer  "copy_file_size"
    t.datetime "copy_updated_at"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.string   "purchase_order_file_name"
    t.string   "purchase_order_content_type"
    t.integer  "purchase_order_file_size"
    t.datetime "purchase_order_updated_at"
    t.text     "message"
    t.text     "reason"
    t.integer  "headquarter_id"
    t.integer  "client_id"
    t.string   "invoice_number"
    t.date     "expiration_date"
    t.integer  "payment_type",                default: 0, null: false
    t.date     "billing_date"
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.integer  "partial_payment"
    t.index ["client_id"], :name => "fk__invoices_client_id"
    t.index ["currency_id"], :name => "fk__invoices_currency_id"
    t.index ["deleted_at"], :name => "index_invoices_on_deleted_at"
    t.index ["headquarter_id"], :name => "fk__invoices_headquarter_id"
    t.index ["slug"], :name => "index_invoices_on_slug", :unique => true
    t.foreign_key ["client_id"], "clients", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_invoices_client_id"
    t.foreign_key ["currency_id"], "currencies", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_invoices_currency_id"
    t.foreign_key ["headquarter_id"], "headquarters", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_invoices_headquarter_id"
  end

  create_table "invoice_contacts", force: :cascade do |t|
    t.integer  "invoice_id"
    t.integer  "contact_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], :name => "fk__invoice_contacts_contact_id"
    t.index ["deleted_at"], :name => "index_invoice_contacts_on_deleted_at"
    t.index ["invoice_id"], :name => "fk__invoice_contacts_invoice_id"
    t.foreign_key ["contact_id"], "contacts", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_invoice_contacts_contact_id"
    t.foreign_key ["invoice_id"], "invoices", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_invoice_contacts_invoice_id"
  end

  create_table "job_experiences", force: :cascade do |t|
    t.integer  "collaborator_id",                      null: false
    t.integer  "type",                     default: 0, null: false
    t.integer  "entity_id",                            null: false
    t.integer  "position_id"
    t.date     "start"
    t.date     "end"
    t.text     "achievements"
    t.text     "functions"
    t.string   "certificate_file_name"
    t.string   "certificate_content_type"
    t.integer  "certificate_file_size"
    t.datetime "certificate_updated_at"
    t.integer  "reference_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["collaborator_id"], :name => "fk__job_experiences_collaborator_id"
    t.index ["deleted_at"], :name => "index_job_experiences_on_deleted_at"
    t.index ["entity_id"], :name => "fk__job_experiences_entity_id"
    t.index ["position_id"], :name => "fk__job_experiences_position_id"
    t.index ["reference_id"], :name => "fk__job_experiences_reference_id"
    t.foreign_key ["collaborator_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_job_experiences_collaborator_id"
    t.foreign_key ["entity_id"], "entities", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_job_experiences_entity_id"
    t.foreign_key ["position_id"], "positions", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_job_experiences_position_id"
    t.foreign_key ["reference_id"], "people", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_job_experiences_reference_id"
  end

  create_table "permits", force: :cascade do |t|
    t.integer  "collaborator_id", null: false
    t.string   "name"
    t.text     "description"
    t.integer  "type_permit"
    t.date     "start"
    t.date     "finish"
    t.integer  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["collaborator_id"], :name => "fk__permits_collaborator_id"
    t.foreign_key ["collaborator_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_permits_collaborator_id"
  end

  create_table "prospect_contacts", force: :cascade do |t|
    t.integer  "prospect_id", null: false
    t.integer  "contact_id",  null: false
    t.datetime "deleted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["contact_id"], :name => "fk__prospect_contacts_contact_id"
    t.index ["deleted_at"], :name => "index_prospect_contacts_on_deleted_at"
    t.index ["prospect_id"], :name => "fk__prospect_contacts_prospect_id"
    t.foreign_key ["contact_id"], "contacts", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_prospect_contacts_contact_id"
    t.foreign_key ["prospect_id"], "prospects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_prospect_contacts_prospect_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.integer  "prospect_id",              null: false
    t.float    "developer_price_per_hour"
    t.float    "designer_price_per_hour"
    t.float    "float"
    t.float    "account_price_per_hour"
    t.float    "total"
    t.integer  "currency_id"
    t.string   "slug"
    t.datetime "deleted_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["currency_id"], :name => "fk__quotations_currency_id"
    t.index ["deleted_at"], :name => "index_quotations_on_deleted_at"
    t.index ["prospect_id"], :name => "fk__quotations_prospect_id"
    t.index ["slug"], :name => "index_quotations_on_slug", :unique => true
    t.foreign_key ["currency_id"], "currencies", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_quotations_currency_id"
    t.foreign_key ["prospect_id"], "prospects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_quotations_prospect_id"
  end

  create_table "quotation_estimations", force: :cascade do |t|
    t.integer  "quotation_id",        null: false
    t.integer  "estimation_id",       null: false
    t.boolean  "selected"
    t.float    "developer_days_est"
    t.float    "developer_hours_est"
    t.float    "developer_price"
    t.float    "designer_days_est"
    t.float    "designer_hours_est"
    t.float    "designer_price"
    t.float    "account_hours_est"
    t.float    "account_price"
    t.datetime "deleted_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["deleted_at"], :name => "index_quotation_estimations_on_deleted_at"
    t.index ["estimation_id"], :name => "fk__quotation_estimations_estimation_id"
    t.index ["quotation_id"], :name => "fk__quotation_estimations_quotation_id"
    t.foreign_key ["estimation_id"], "estimations", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_quotation_estimations_estimation_id"
    t.foreign_key ["quotation_id"], "quotations", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_quotation_estimations_quotation_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "collaborator_id"
    t.integer  "person_id"
    t.integer  "type",            default: 0,     null: false
    t.boolean  "emergency",       default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["collaborator_id"], :name => "fk__relationships_collaborator_id"
    t.index ["deleted_at"], :name => "index_relationships_on_deleted_at"
    t.index ["person_id"], :name => "fk__relationships_person_id"
    t.foreign_key ["collaborator_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_relationships_collaborator_id"
    t.foreign_key ["person_id"], "people", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_relationships_person_id"
  end

  create_table "schedule_bases", force: :cascade do |t|
    t.integer  "schedule_id", null: false
    t.string   "name",        null: false
    t.date     "start"
    t.date     "finish"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["schedule_id"], :name => "fk__schedule_bases_schedule_id"
    t.foreign_key ["schedule_id"], "schedules", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_schedule_bases_schedule_id"
  end

  create_table "schedule_logs", force: :cascade do |t|
    t.integer  "schedule_id", null: false
    t.string   "inTime"
    t.string   "outTime"
    t.integer  "day_of_week", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["schedule_id"], :name => "fk__schedule_logs_schedule_id"
    t.foreign_key ["schedule_id"], "schedules", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_schedule_logs_schedule_id"
  end

  create_table "studies", force: :cascade do |t|
    t.integer  "collaborator_id"
    t.integer  "type",                     default: 0, null: false
    t.integer  "degree",                   default: 0, null: false
    t.date     "start"
    t.date     "end"
    t.integer  "entity_id"
    t.string   "certificate_file_name"
    t.string   "certificate_content_type"
    t.integer  "certificate_file_size"
    t.datetime "certificate_updated_at"
    t.datetime "deleted_at"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["collaborator_id"], :name => "fk__studies_collaborator_id"
    t.index ["deleted_at"], :name => "index_studies_on_deleted_at"
    t.index ["entity_id"], :name => "fk__studies_entity_id"
    t.foreign_key ["collaborator_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_studies_collaborator_id"
    t.foreign_key ["entity_id"], "entities", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_studies_entity_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.datetime "deleted_at"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], :name => "fk__tasks_account_id"
    t.foreign_key ["account_id"], "accounts", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_tasks_account_id"
  end

  create_table "task_projects", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], :name => "fk__task_projects_project_id"
    t.index ["task_id"], :name => "fk__task_projects_task_id"
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_task_projects_project_id"
    t.foreign_key ["task_id"], "tasks", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_task_projects_task_id"
  end

  create_table "time_stations", force: :cascade do |t|
    t.integer  "collaborator_id"
    t.float    "total_time",      default: 0.0
    t.integer  "parent_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["collaborator_id"], :name => "fk__time_stations_collaborator_id"
    t.index ["parent_id"], :name => "fk__time_stations_parent_id"
    t.foreign_key ["collaborator_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_time_stations_collaborator_id"
    t.foreign_key ["parent_id"], "time_stations", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_time_stations_parent_id"
  end

  create_table "timesheets", force: :cascade do |t|
    t.integer  "collaborator_id"
    t.integer  "task_id"
    t.integer  "project_id"
    t.datetime "start_time"
    t.datetime "stop_time"
    t.float    "total_time",      default: 0.0
    t.boolean  "running",         default: false
    t.string   "notes"
    t.date     "belong_to_day"
    t.datetime "deleted_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["collaborator_id"], :name => "fk__timesheets_collaborator_id"
    t.index ["deleted_at"], :name => "index_timesheets_on_deleted_at"
    t.index ["project_id"], :name => "fk__timesheets_project_id"
    t.index ["task_id"], :name => "fk__timesheets_task_id"
    t.foreign_key ["collaborator_id"], "collaborators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_timesheets_collaborator_id"
    t.foreign_key ["project_id"], "projects", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_timesheets_project_id"
    t.foreign_key ["task_id"], "tasks", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_timesheets_task_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             default: "",   null: false
    t.string   "last_name",              default: "",   null: false
    t.string   "image",                  default: "",   null: false
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "uid",                    default: "",   null: false
    t.string   "provider",               default: "",   null: false
    t.string   "token",                  default: "",   null: false
    t.string   "refresh_token",          default: "",   null: false
    t.integer  "expires_at",             default: 0,    null: false
    t.boolean  "expires",                default: true, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "slug"
    t.datetime "deleted_at"
    t.integer  "users"
    t.integer  "team"
    t.integer  "integer"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmed_sent_at"
    t.index ["deleted_at"], :name => "index_users_on_deleted_at"
    t.index ["email"], :name => "index_users_on_email", :unique => true
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
    t.index ["slug"], :name => "index_users_on_slug", :unique => true
  end

end

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

ActiveRecord::Schema.define(version: 20161107132942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "becados_por_fundacions", force: :cascade do |t|
    t.integer  "becado_id"
    t.integer  "fundacion_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "becados_por_fundacions", ["becado_id", "fundacion_id"], name: "index_becados_por_fundacions_on_becado_id_and_fundacion_id", unique: true, using: :btree

  create_table "clases", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.string   "contenido"
    t.date     "fecha"
    t.time     "hora_inicio"
    t.time     "hora_fin"
    t.integer  "curso_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "clases", ["curso_id"], name: "index_clases_on_curso_id", using: :btree

  create_table "cuestionarios", force: :cascade do |t|
    t.integer  "encuesta_id"
    t.string   "pregunta"
    t.string   "respuesta"
    t.integer  "cantEstrellas", default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "cursos", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.string   "contenido"
    t.date     "fecha_inicio"
    t.date     "fecha_fin"
    t.integer  "cupos"
    t.integer  "user_id"
    t.integer  "relacion_b_nb"
    t.string   "tipo_actividad"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "finalizado",     default: false
    t.integer  "location_id"
    t.boolean  "activo",         default: true
    t.decimal  "monto"
    t.boolean  "efectivo",       default: false
    t.boolean  "tarjeta",        default: false
    t.boolean  "publicado",      default: false
  end

  create_table "encuests", force: :cascade do |t|
    t.integer  "curso_id"
    t.integer  "encuestado_id"
    t.integer  "encuestador_id"
    t.boolean  "completada",     default: false
    t.string   "comentario"
    t.integer  "puntuacion"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "encuests", ["curso_id"], name: "index_encuests_on_curso_id", using: :btree

  create_table "inscripcions", force: :cascade do |t|
    t.integer  "inscripto_id"
    t.integer  "clase_id"
    t.boolean  "presencia"
    t.boolean  "pago"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "inscripcions", ["clase_id"], name: "index_inscripcions_on_clase_id", using: :btree
  add_index "inscripcions", ["inscripto_id"], name: "index_inscripcions_on_inscripto_id", using: :btree

  create_table "inscriptos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "curso_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "tipe"
    t.integer  "payment_id"
  end

  add_index "inscriptos", ["curso_id"], name: "index_inscriptos_on_curso_id", using: :btree
  add_index "inscriptos", ["user_id"], name: "index_inscriptos_on_user_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "address"
    t.string   "city"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "number"
    t.integer  "floor"
    t.string   "dep"
    t.string   "postal_code"
    t.string   "state"
    t.string   "description"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_user_id"
    t.integer  "subject_user_id"
    t.string   "text"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "is_view",         default: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "mensaje"
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "is_view",    default: false
  end

  create_table "payment_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "tipe"
    t.integer  "user_id"
    t.string   "authorization"
    t.string   "merchant"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "ciudad"
    t.string   "telefono"
    t.string   "cod_postal"
    t.string   "estado"
    t.string   "direccion"
  end

  create_table "payments", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "external_id"
    t.string   "external_referent"
    t.decimal  "amount"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.boolean  "state"
    t.integer  "payment_type_id"
  end

  create_table "recursos", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "user_id"
    t.integer  "curso_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "conseguido",  default: false
    t.string   "tipe"
    t.string   "description"
  end

  add_index "recursos", ["curso_id"], name: "index_recursos_on_curso_id", using: :btree

  create_table "reputacions", force: :cascade do |t|
    t.integer  "SUM_ProfesorRecomendado", default: 0
    t.integer  "AVG_ReputacionProfesor",  default: 0
    t.integer  "AVG_ReputacionAlumno",    default: 0
    t.float    "PCT_AsistenciaAClases",   default: 0.0
    t.integer  "SUM_CursosCreados",       default: 0
    t.integer  "SUM_CursosInscriptos",    default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "user_id"
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "lastname"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.integer  "active"
    t.string   "role"
    t.string   "imagen"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "location_id"
    t.string   "phone"
    t.string   "habilidades"
    t.string   "notas"
    t.string   "experiencia"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "clases", "cursos"
  add_foreign_key "encuests", "cursos"
  add_foreign_key "inscripcions", "clases"
  add_foreign_key "inscripcions", "inscriptos"
  add_foreign_key "inscriptos", "cursos"
  add_foreign_key "inscriptos", "users"
  add_foreign_key "recursos", "cursos"
end

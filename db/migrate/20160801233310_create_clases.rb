class CreateClases < ActiveRecord::Migration
  def change
    create_table :clases do |t|
      t.string :nombre
      t.string :descripcion
      t.string :contenido
      t.date :fecha
      t.time :hora_inicio
      t.time :hora_fin
      t.references :curso, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end

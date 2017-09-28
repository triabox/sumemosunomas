class CreateEncuests < ActiveRecord::Migration
  def change
    create_table :encuests do |t|
      t.references :curso, index: true, foreign_key: true
      t.integer :encuestado_id
      t.integer :encuestador_id
      t.boolean :completada, default: false
      t.string :comentario
      t.integer :puntuacion
      t.timestamps null: false
    end
  end
end

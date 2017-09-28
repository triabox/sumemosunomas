class CreateCuestionarios < ActiveRecord::Migration
  def change
    create_table :cuestionarios do |t|
      t.integer :encuesta_id
      t.string :pregunta
      t.string :respuesta
      t.integer :cantEstrellas, default: 0

      t.timestamps null: false
    end
  end
end

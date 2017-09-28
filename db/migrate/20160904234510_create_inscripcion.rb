class CreateInscripcion < ActiveRecord::Migration
  def change
    create_table :inscripcions do |t|
      t.references :inscripto, index: true, foreign_key: true
      t.references :clase, index: true, foreign_key: true
      t.boolean :presencia
      t.boolean :pago
      t.timestamps null: false
    end
  end
end

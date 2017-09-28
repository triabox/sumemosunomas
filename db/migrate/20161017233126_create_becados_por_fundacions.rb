class CreateBecadosPorFundacions < ActiveRecord::Migration
  def change
    create_table :becados_por_fundacions do |t|
      t.integer :becado_id
      t.integer :fundacion_id
      t.timestamps null: false
    end
  end
end

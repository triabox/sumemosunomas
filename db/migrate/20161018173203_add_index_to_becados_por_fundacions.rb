class AddIndexToBecadosPorFundacions < ActiveRecord::Migration
  def change
    add_index :becados_por_fundacions, ["becado_id", "fundacion_id"], :unique => true
  end
end

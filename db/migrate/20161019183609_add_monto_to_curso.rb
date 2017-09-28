class AddMontoToCurso < ActiveRecord::Migration
  def change
    add_column :cursos, :monto, :decimal
  end
end

class ChangeTypeOfReputacion < ActiveRecord::Migration
  def change
    change_column :reputacions, :AVG_ReputacionProfesor, :integer, default: 0
    change_column :reputacions, :AVG_ReputacionAlumno, :integer, default: 0
  end
end
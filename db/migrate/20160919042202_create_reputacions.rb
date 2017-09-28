class CreateReputacions < ActiveRecord::Migration
  def change
    create_table :reputacions do |t|
      t.integer :SUM_ProfesorRecomendado, default:0
      t.float :AVG_ReputacionProfesor, default: 0
      t.float :AVG_ReputacionAlumno, default: 0
      t.float :PCT_AsistenciaAClases, default: 0
      t.integer :SUM_CursosCreados, default: 0
      t.integer :SUM_CursosInscriptos, default: 0
      t.timestamps null: false
    end
  end
end

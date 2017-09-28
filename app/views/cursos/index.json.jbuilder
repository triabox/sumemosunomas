json.array!(@cursos_creados) do |curso|
  json.extract! curso, :id, :nombre, :descripcion, :contenido, :fecha_inicio, :fecha_fin, :cupos, :relacion_b_nb
  json.url curso_url(curso, format: :json)
end

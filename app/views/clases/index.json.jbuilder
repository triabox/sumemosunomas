json.array!(@clases) do |clase|
  json.extract! clase, :id, :nombre, :descripcion, :contenido, :fecha, :hora_inicio, :hora_fin, :curso_id
  json.url clase_url(clase, format: :json)
end

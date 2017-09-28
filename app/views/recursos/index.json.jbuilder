json.array!(@recursos) do |recurso|
  json.extract! recurso, :id, :nombre, :curso_id, :user_id
  json.url clase_url(recurso, format: :json)
end
